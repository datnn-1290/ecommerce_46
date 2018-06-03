class SessionsController < ApplicationController
  def new
    session[:return_product] = params[:product_id] if params[:product_id]
    return unless logged_in?
    flash[:info] = t ".logged_in"
    redirect_to root_url
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        if(session[:return_product])
          product_id = session[:return_product]
          session.delete :return_product
          redirect_to product_path(id: product_id)
        else
          redirect_back_or root_path
        end
      else
        flash[:warning] = t ".activate_message"
        redirect_to root_path
      end
    else
      flash.now[:danger] = t ".activate_fail"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
