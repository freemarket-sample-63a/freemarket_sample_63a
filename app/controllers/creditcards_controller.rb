class CreditcardsController < ApplicationController
  require "payjp"
  before_action :set_card , only: [:new]

  def new
    redirect_to action: "show" if @card.exists?
    gon.payip_access_key = ENV['PAYJP_KEY']
  end

  def pay
    binding.pry
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', 
      email: current_user.email, 
      card: params['payjp-token'], 
      metadata: {user_id: current_user.id},
      ) 
      @card = Creditcard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)

      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end 
    end
  end

  def destroy
    card = Creditcard.where(user_id: current_user.id).first
    if card.present?
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
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  private
    def set_card
      @card =  Creditcard.where(user_id: current_user.id)
    end
end