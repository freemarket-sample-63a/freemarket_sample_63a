class CreditcardsController < ApplicationController
  require "payjp"

  def new
    card =  Creditcard.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def pay 
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    
    if params['payip-token'].blank?
      redirect_to action: "new"
    else  
      customer = Payjp::Customer.create(
        email: current_user.email, 
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @card = Creditcard.new(user_id: current_user.id, customer: customer.id, pay_token:params['payjp-token'])

      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end 
    end
  end

  def delete 
    card = Creditcard.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end

  def show 
    card = Creditcard.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer)
      @default_card_information = customer.cards.retrieve(card.pay_token)
    end
  end
end