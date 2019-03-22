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
      seller_dispute_message
      buyer_dispute_message

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

  def seller_dispute_message
    SellerMailer.seller_dispute_message(@order.product.seller).deliver_now
  end

  def buyer_dispute_message
    UserMailer.buyer_dispute_message(@order.user).deliver_now
  end

end
