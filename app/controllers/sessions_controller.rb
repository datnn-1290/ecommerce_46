class SessionsController < ApplicationController

  def callback
    if user = User.from_facebook(request.env["omniauth.auth"])
      flash[:success] = t "login_facebook_success"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = t "login_facebook_error"
      redirect_to request.referrer
    end
  end

  def new
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
        redirect_back_or root_path
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
