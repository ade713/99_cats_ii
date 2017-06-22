class UsersController < ApplicationController
  before_action :require_logged_out

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.reset_session_token!

    if @user.save
      login_user!(@user)
      redirect_to cats_url
    else
      render json: ["Invalid user inputs"]
    end
  end


  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
