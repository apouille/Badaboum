class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_first_name!

  def index
    @users = User.all
    @conversations = Conversation.all
  end

  def create
    if params[:status].present? && params[:status] == 'dispute'
      
      @order = Order.find(params[:order])
      
      #Je mets à jour mes status
      @order.update(status: 'dispute')
      @order.product.update(state: 'sold')

      #Je déclenche les notifications mails
      # à remplir

      flash[:notice] = "Nous avons ouvert votre litige. Merci de cliquer sur la discussion avec l'admin pour spécifier votre demande."
    end

    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],
      params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    redirect_to conversation_messages_path(@conversation)
  end

  private
  
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

end
