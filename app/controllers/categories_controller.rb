class CategoriesController < ApplicationController
  before_action :find_products_by_category, only: %i(show)
  before_action :load_all_category, only: %i(show index)

  private

  def find_products_by_category
    category = Category.find_by id: params[:id]
    @products = category.product
  end

  def load_all_category
    @categories = Category.all
  end
end
