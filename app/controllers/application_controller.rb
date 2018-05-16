class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_all_category
  before_action :create_cart
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".must_login"
      redirect_to login_url
    end
  end

  def load_all_category
    @categories = Category.all
  end

  def create_cart
    @cart = Cart.build_cart session[:cart]
  end

  def update_cart
    session[:cart] = @cart
  end
end
