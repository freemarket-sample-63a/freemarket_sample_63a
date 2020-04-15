class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    if @category.descendant_ids.present?
      @items = Item.where(category_id: @category.descendant_ids)      
    else
      @items = Item.where(category_id: @category.id)  
    end
  end
end