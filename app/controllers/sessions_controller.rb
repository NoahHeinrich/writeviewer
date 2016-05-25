class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to current_user
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
    session[:user_id] = @user.id
    redirect_to @user
    else
      flash[:danger] = "Login information not found"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    render 'new'
  end

  private
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    session[:user_id] ? true : false
  end
end