class Api::CategoriesController < ApplicationController
  skip_before_action :set_header_categories,:set_header_brands
  def index
    @categories = Category.where(ancestry: params[:id])
    respond_to do |format|
      format.json
    end
  end
end
