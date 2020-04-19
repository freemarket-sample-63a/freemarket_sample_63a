class ItemsController < ApplicationController
  before_action :set_user_address,only: :create
  before_action :set_categories, :set_shippingways,:set_brands,only:[:new,:edit]
  before_action :set_item,only: [:edit,:show,:destroy]

  def index
  end
  
  def new
    @item = Item.new(feerate: 0.1)
    @item.feerate = 0.1
    @item_image = @item.item_images.build
  end

  def create
    @item = Item.new(item_params)
    @item["user_id"] = current_user.id
    @item["address_id"] = @address.id
    if @item.price.nil?
      redirect_to new_item_path, notice:"販売価格を入力してください"
      return
    end
    if @item.profit_price.nil?
      redirect_to new_item_path, notice:"販売利益の取得に失敗しました。販売価格をもう一度入力してください"
      return
    end
    if params[:item_images] 
      if @item.save
        params[:item_images]['image'].each do |img|
          @image = @item.item_images.create(image: img, item_id: @item.id)
        end
      else
        redirect_to new_item_path, notice:"必要な情報が不足していたため商品が登録できませんでした。"
        return
      end
      @item = Item.find(@item.id)
      if @item.item_images.empty?
        @item.destroy
        redirect_to new_item_path, notice:"拡張子がjpeg,jpg,pngのファイルを選択してください"
        return
      end
      redirect_to item_path(@item.id)
      return
    else 
      redirect_to new_item_path, notice:"画像がない商品は登録できません。"
      return
    end
  end

  def show
  end


  def edit
    gon.item_images = @item.item_images
  end

  def update
    item = Item.find(params[:id])
    if params[:item]['item_images_attributes']['0']['_destroy'] == "1"
      redirect_to edit_item_path(item.id), notice:"画像がない商品は登録できません。"
    else
      if item.update(item_update_params)
        redirect_to item_path(item.id)
      else
        redirect_to item_path(item.id), notice:"出品情報の更新に失敗しました。"
      end
    end
  end

  def destroy
    if @item.destroy
      render :destroy
    else
      redirect_to item_path(@item.id), notice:"商品を削除できませんでした"
      return
    end
  end

  private
    def item_params
      params.require(:item).permit(:brand_id,:category_id,:shippingway_id,:product_size_id,:condition_num,:daystoship_num,:title,:description,:price,:feerate,:profit_price, [item_images_attributes: [:id, :image]])
    end

    def item_update_params
      params.require(:item).permit(:brand_id,:category_id,:shippingway_id,:product_size_id,:condition_num,:daystoship_num,:title,:description,:price,:feerate,:profit_price, [item_images_attributes: [:image, :_destroy, :id]])
    end

    def set_user_address
      if @address = Address.find_by(user_id: current_user.id,status_num: 0)
      else
        redirect_to user_addresses_path(current_user.id), notice:"アドレスの登録がないと商品の登録ができません。"
        return
      end
    end

    def set_item
      @item = Item.find(params[:id])
    end
    def set_categories
      @categories = []
      @categories.push(Category.new(id:0,name:"---"))
      @categories.concat(Category.where(ancestry: nil))
    end
    def set_shippingways
      @shippingways = []
      @shippingways.push(Shippingway.new(id:0,name:"---"))
      @shippingways.concat(Shippingway.where(ancestry: nil))
    end
    def set_brands
      @brands = []
      @brands.push(Brand.new(id: nil,name:"例)シャネル"))
      @brands.concat(Brand.all)
    end
end