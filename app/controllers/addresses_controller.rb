class AddressesController < ApplicationController

  def index
    @addresses = Address.where(user_id: current_user.id)
  end
  
  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      Address.create(address_params)
    else
      render user_address_path
    end
    redirect_to user_addresses_path
  end

  def edit
  end

  def update
  end

  
  private
  def address_params
    params.required(:address).permit(:first_name, :last_name, :frist_name_kana, :last_name_kana, :area_id, :building, :city, :number, :postal_number, :status_nun, :telephone_number).merge(user_id: current_user.id, status_num: 0)
  end

end
