class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      successful_log_in(@user)
    else
      unsuccessful_log_in
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def successful_log_in(user)
    session[:user_id] = user.id
    redirect_to links_path
    flash[:success] = "Logged in."
  end

  def unsuccessful_log_in
    redirect_to login_path
    flash[:danger] = "Invalid login information"
  end
end
