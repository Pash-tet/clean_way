class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  before_action :check_sign_in, only: %i[new create]
  wrap_parameters :user

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      start_new_session_for(@user)
      redirect_to after_authentication_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    render Views::Users::Show.new
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
