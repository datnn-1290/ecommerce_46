class ItemsController < ApplicationController
  before_action :load_item, only: %i(create update destroy)
  after_action :update_cart, only: %i(create update destroy)
  before_action :create_cart, only: %i(create)

  def show; end

  def create
    @cart.update_quantity_item params[:product_id], params[:quantity]
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end

  private

  def load_item
    @item = @cart.items.find {|item| item.product_id == params[:product_id]} if @cart
  end
end
