class Message < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :subject
end
