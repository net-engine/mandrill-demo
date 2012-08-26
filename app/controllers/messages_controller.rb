class MessagesController < ApplicationController
  load_and_authorize_resource

  def index
    @new_message = flash[:failed_message] || current_user.messages.new
  end

  def create
    if @message.save
      flash[:notice] = t('messages.flashes.create_success')
    else
      flash[:failed_message] = @message
    end
    redirect_to messages_root_path
  end
end
