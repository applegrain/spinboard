class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      successful_log_in(@user)
    else
      unsuccessful_log_in
    end
  end

  private

  def successful_log_in(user)
    session[:user_id] = user.id
    redirect_to links_path
  end

  def unsuccessful_log_in
    flash[:danger] = "Unable to login."
    redirect_to sign_up_path
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
