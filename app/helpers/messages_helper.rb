module MessagesHelper
  def recipient
    if current_user.id == @message.conversation.sender.id
      return @message.conversation.recipient
    elsif current_user.id == @message.conversation.recipient.id
      return @message.conversation.sender
    end
  end
end
