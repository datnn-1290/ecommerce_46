class OrdersController < ApplicationController
  before_action :logged_in_user

  def index
    @cart = session[:cart]
    @user = current_user
  end

  def create
    flash[:success] = "Order success"
    redirect_to root_path
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
