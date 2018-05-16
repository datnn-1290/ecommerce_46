class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: %(index create)
  rescue_from ActiveRecord::RecordInvalid, with: :redirect_to_homepage

  def index
    @cart = session[:cart]
    @user = current_user
  end

  def create
    order = current_user.orders.build order_params
    order.status = Order.statuses[:pending]
    order.place_an_order order, session[:cart]
    flash[:success] = t "order_success"
    session.delete :cart
    redirect_to root_path
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "require_login"
      redirect_to login_url
    end
  end

  def correct_user
    error_redirect unless current_user
  end

  def order_params
    params.require(:order).permit :name, :phone, :address,
    :note
  end

  def redirect_to_homepage
    flash[:error] = t "error"
    redirect_to root_path
  end
end
