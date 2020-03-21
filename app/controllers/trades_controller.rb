class TradesController < ApplicationController
  protect_from_forgery except: [:create]
  before_action :get_item, :get_card, :get_trade, only: [:index, :new, :create, :fail]

  def index

  end

  def new

  end

  def create
    #支払い処理
    card = Creditcard.find_by(user_id: current_user.id)
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    pay = Payjp::Charge.create(
      :amount => @item.price.to_i, #decimalをintegerに変換
      :customer => card.customer_id, #顧客ID 
      :currency => 'jpy', #日本円
    )

    if pay.paid
      #支払処理成功後のTradeレコード登録処理
      trade = Trade.new(trade_params)
      unless trade.save
        trade_failed 
      end
    else
      trade_failed 
    end
  end

  private

  def get_item
    @user = current_user
    @item = Item.find(params[:item_id])
    @item_image = @item.item_images.build
    @address = Address.find_by(user_id: current_user.id)
  end

  def get_card
    card =  Creditcard.find_by(user_id: current_user.id)
    unless card.nil?
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def get_trade
    @trade = Trade.find_by(item_id: params[:item_id])
    if @trade.nil?
      @trade = Trade.new
      @trade.user_id = current_user.id
      @trade.item_id = @item.id
      @trade.address_id = @address.id
    end 
  end

  def trade_params
    params.require(:trade).permit(:item_id,:user_id,:address_id)
  end

  def trade_failed
    redirect_to action: 'fail' #購入失敗画面に移動 
  end

end
