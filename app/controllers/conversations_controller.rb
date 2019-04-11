class ConversationsController < ApplicationController
    
    # List of conversations.
    def index
        conversations = Conversation.all
        render json: conversations
    end

    # Action to create a conversation.
    def create
        conversation = Conversation.new(conversation_params)
        if conversation.save
            serialized_data = ActiveModelSerializers::Adapter::Json.new(
                ConversationSerializer.new(conversation)
            ).serialized_hash
            ActionCable.server.broadcast 'conversation_channel', serialized_data
            head :ok
        end
    end

    private

    def conversation_params
        params.require(:conversation).permit(:title)
    end
end
