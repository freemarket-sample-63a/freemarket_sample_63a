class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @items = Item.where(category_id: @category.descendant_ids)
  end
end