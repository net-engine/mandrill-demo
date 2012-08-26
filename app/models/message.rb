class Message < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :subject, :delivery_status, :last_status_update, :opens, :clicks

  validates :content, :subject, presence: true

  before_save :set_last_status_update
  after_create :send_via_mandrill

  def send_via_mandrill
    mandrill = Mandrill::API.new ENV["MANDRILL_API_KEY"]
    mm = MandrillMessage.new(self)
    mandrill.messages.send_template(mm.template_name, mm.template_content, mm.data)
  end

  def update_mandrill_status
    mandrill = Mandrill::API.new ENV["MANDRILL_API_KEY"]
    result = mandrill.messages.search("u_message_id:#{self.id}").first rescue nil
    return unless result
    latest_attrs = {  last_status_update: Time.now,
                      delivery_status: result["state"],
                      clicks: result["clicks"].to_i,
                      opens: result["opens"].to_i
                    }
    self.update_attributes latest_attrs
  end

  def mandrill_search_result
    mandrill = Mandrill::API.new ENV["MANDRILL_API_KEY"]
    result = mandrill.messages.search("u_message_id:#{self.id}").first rescue nil
  end

  def status_label
    case delivery_status
    when "queued"
      "label-info"
    when "sent"
      "label-success"
    when "bounced"
      "label-important"
    else
      "label-warning"
    end
  end

  private
  def set_last_status_update
    self.last_status_update = Time.now
  end
end