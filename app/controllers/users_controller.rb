class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  wrap_parameters :user

  def new
    @errors = {}
    @user = User.new
  end

  def create
    @errors = {}

    Auth::SignUp.new.call(user_params:) do |r|
      r.success do |user|
        start_new_session_for(user)
        redirect_to after_authentication_url
      end
      r.failure do |errors|
        @errors = errors
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
