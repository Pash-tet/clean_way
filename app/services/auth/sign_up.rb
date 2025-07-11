module Auth
  # Auth::SignUp
  class SignUp < ApplicationService
    # step :validate
    step :create_user

    def validate(user_params:)
      user = User.new(user_params)

      user.valid? ? Success(user) : Failure(user_errors(user.errors))
    end

    def create_user(user)
      user.save ? Success(user) : Failure(user)
    end

    private

    def user_errors(errors)
      result = User::Errors.new

      name_is_taken_error = errors.where(:name, :taken).first
      result.name = "Уже занят" if errors.where(:name).delete(name_is_taken_error).present?
      result.name ||= "Неверный формат ()" if errors.where(:name).any?
      # errors = "Уже занят" if errors.where(:name, typ)
      result
    end
  end
end
