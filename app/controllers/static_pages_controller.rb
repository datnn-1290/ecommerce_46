class StaticPagesController < ApplicationController
  def home
    @categories = Category.all
    @hot_products = Product.hot_product(Settings.product.lastest_month)
    @lastest_products = Product.lastest_product(Settings.product.limit)
  end
end
