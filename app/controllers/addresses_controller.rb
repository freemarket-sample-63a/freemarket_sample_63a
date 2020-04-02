class AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update, :destroy]
  before_action :must_not_destroy_child_eixts, only: [:destroy]

  def index
    @addresses = Address.where(user_id: current_user.id)
  end
  
  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    render :new and return unless @address.save
    redirect_to user_addresses_path, notice: "新規住所を登録しました"
  end

  def edit
  end

  def update
    render :edit and return unless @address.update(address_params)
    redirect_to user_addresses_path, notice: "住所を編集しました"
  end

  def destroy
    if must_not_destroy_child_eixts
      render :index and return unless @address.destroy
      redirect_to user_addresses_path, notice:"住所を削除しました" 
    else
      redirect_to user_addresses_path, notice:"出品または購入に利用した住所は削除できません" 
    end
  end

  
  private
  def address_params
    params.required(:address).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :area_id, :building, :city, :number, :postal_number, :status_nun, :telephone_number).merge(user_id: current_user.id, status_num: 0)
  end

  def set_address
    @address = Address.find(params[:id])
  end

  def must_not_destroy_child_eixts
    return @address.items.empty? && @address.trades.empty?  
  end

end
