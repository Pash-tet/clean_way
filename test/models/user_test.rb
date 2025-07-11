require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should error with invalid name message when name has invalid format" do
    user = User.new(name: "asd%#$%")

    refute(user.valid?, "user must be invalid")
    assert_match(
      user.errors.where(:name, :invalid).first.message,
      "имеет неверное значение (длина от 4 до 64, символы A-Z, a-z, 0-9, _, -)",
      "show name has invalid name message"
    )
  end

  test "should error with invalid name message when name absent" do
    user = User.new(name: nil)

    refute(user.valid?, "user must be invalid")
    assert_match(
      user.errors.where(:name, :invalid).first.message,
      "имеет неверное значение (длина от 4 до 64, символы A-Z, a-z, 0-9, _, -)",
      "show name has invalid name message"
    )
  end

  test "should error with take type on name then name already taken" do
    users(:test)
    user = User.new(name: "Test")

    refute(user.valid?)
    assert_match(
      user.errors.where(:name, :taken).first.message,
      "уже занято"
    )
  end
end
