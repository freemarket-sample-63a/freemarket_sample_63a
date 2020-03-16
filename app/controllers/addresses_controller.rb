class AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update, :destroy]

  def index
    @addresses = Address.where(user_id: current_user.id)
  end
  
  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    render :new and returne unless @address.save
    render user_address_path and return unless @address.save
  end

  def edit
  end

  def update
    render :edit and returne unless @address.update(address_params)
    redirect_to user_addresses_path
  end

  def destroy
    @address.destroy
    redirect_to user_addresses_path
  end

  
  private
  def address_params
    params.required(:address).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :area_id, :building, :city, :number, :postal_number, :status_nun, :telephone_number).merge(user_id: current_user.id, status_num: 0)
  end

  def set_address
    @address = Address.find(params[:id])
  end
end
