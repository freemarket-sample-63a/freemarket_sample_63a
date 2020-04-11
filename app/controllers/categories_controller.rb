class CategoriesController < ApplicationController
  skip_before_action :set_header_categories,:set_header_brands
  def show
    @categories = Category.where(ancestry: params[:id])
  end
end