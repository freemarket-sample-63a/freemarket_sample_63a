class TopsController < ApplicationController
  def index
    @brands = Brand.order("RAND()").limit(1)
    ids = @brands.ids
    @items = Item.for_sale_only.order('items.created_at desc').limit(3)
    @items_brands = Item.where(brand_id: id).order('items.created_at desc').limit(3)
  end
end