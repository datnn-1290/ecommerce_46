class ItemsController < ApplicationController
  after_action :update_cart, only: %i(create update destroy)
  before_action :load_item, only: %i(create update destroy)

  def show
    render json: @cart.items
  end

  def create
    @cart.update_item params[:product_id], params[:quantity]
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end

  def update
    if @item.present?
      @item.qty = params[:quantity].to_i
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
  end

  def destroy
    @cart.items.delete_if {|item| item.product_id == params[:product_id]}
    flash[:success] = t ".success"
  end

  private

  def load_item
    @item = @cart.items.find {|item| item.product_id == params[:product_id]}
  end
end
