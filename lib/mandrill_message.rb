class MandrillMessage
  def initialize(message)
    @message = message
    @sender = message.user
  end

  def template_name
    "horse"
  end

  def template_content
    [
      {content: @message.content}
    ]
  end

  def data
    {
      subject: @message.subject,
      from_email: "mandrilldemo@dansowter.com",
      from_name: "Mandrill Demo",
      to: [
          {
              email: @sender.email,
              name: @sender.name
          }
      ],
      track_opens: true,
      track_clicks: true,
      auto_text: true,
      metadata: {
          message_id: @message.id.to_s
      }
    }
  end
end
