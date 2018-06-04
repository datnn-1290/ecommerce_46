class OrdersController < ApplicationController
  before_action :check_user
  before_action :check_cart, only: :index

  def index
    @cart = session[:cart]
    @order = current_user.orders.build
    current_cart.each do |item|
      @order.order_details.build(quantity: item["quantity"], price: item["price"],
        product_id: item["product_id"])
    end
  end

  def create
    @order = current_user.orders.build order_params
    @order.status = Order.statuses[:pending]
    @order.save
    session.delete :cart
    flash[:success] = t "order_success"
    redirect_to root_path
  end

  private

  def order_params
    params.require(:order).permit(:name, :phone, :address, :note, :total,
      order_details_attributes: [:id, :quantity, :price, :order_id, :product_id])
  end

  def check_cart
    redirect_to root_path unless current_cart.present?
  end

  def check_user
    unless logged_in?
      store_location
      flash[:danger] = t "require_login"
      redirect_to login_url
    else
      error_redirect unless current_user
    end
  end
end
