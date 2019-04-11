class MessagesChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find(params[:conversation])
    stream_from conversation
  end

  def unsubscribed
  
  end
end
