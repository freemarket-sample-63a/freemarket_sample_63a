class ItemsController < ApplicationController
  before_action :set_user_address,only: :create
  before_action :set_item,only: [:edit,:show,:destroy]

  def index
  end
  
  def new
    @item = Item.new(feerate: 0.1)
    @item_image = @item.item_images.build
    @categories = []
    @categories.push(Category.new(id:0,name:"---"))
    @categories.concat(Category.where(ancestry: nil))
  end

  def create
    @item = Item.new(item_params)
    @item["user_id"] = current_user.id
    @item["address_id"] = @address.id
    @item["feerate"] = 0.1
    @item["profit_price"] = @item.price - (@item.price * @item.feerate)
    
    if @item.save
      params[:item_images]['image'].each do |img|
        @item_image = @item.item_images.create(image: img, item_id: @item.id)
      end
      redirect_to item_path(@item.id)
    end
  end

  def show
  end


  def edit
    @categories = []
    @categories.push(Category.new(id:0,name:"---"))
    @categories.concat(Category.where(ancestry: nil))
    binding.pry
  end

  def update
  end

  def destroy
    @item.destroy
  end

  private
    def item_params
      params.require(:item).permit(:brand_id,:category_id,:shippingway_id,:product_size_id,:condition_num,:daystoship_num,:title,:description,:price, item_images_attributes: [:id, :item_id, :image])
    end

    def set_user_address
      @address = Address.find_by(user_id: current_user.id,status_num: 0)
    end

    def set_item
      @item = Item.find(params[:id])
    end
end