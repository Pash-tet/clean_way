class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  before_action :check_sign_in, only: %i[new create]
  rate_limit to: 10,
             within: 3.minutes,
             only: :create,
             with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    user = User.authenticate_by(params.permit(:name, :password))

    if user
      start_new_session_for(user)
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Неверное имя или пароль"
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end

  private

  def check_sign_in
    redirect_to root_path if authenticated?
  end
end
