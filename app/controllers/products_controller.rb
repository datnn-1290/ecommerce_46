class ProductsController < ApplicationController
  before_action :load_all_category, only: %i(new edit show)

  def show
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "cant_find_product"
    redirect_to root_url
  end

  def index
    @products = Product.search_by_name params[:name] if params[:name]
  end

  private

    def load_all_category
      @categories = Category.all
    end
end
