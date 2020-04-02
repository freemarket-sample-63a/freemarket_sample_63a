class TopsController < ApplicationController
  def index
    @brands = Brand.order("RAND()").limit(1)
    ids = @brands.ids
    @items = Item.order('items.created_at desc').limit(3)
    @items_brands = Item.where(brand_id: ids).order('items.created_at desc').limit(3)
  end
end