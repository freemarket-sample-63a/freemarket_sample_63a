class AddressesController < ApplicationController

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
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    render :edit and returne unless @address.update(address_params)
    redirect_to user_addresses_path
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to user_addresses_path
  end

  
  private
  def address_params
    params.required(:address).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :area_id, :building, :city, :number, :postal_number, :status_nun, :telephone_number).merge(user_id: current_user.id, status_num: 0)
  end

end
