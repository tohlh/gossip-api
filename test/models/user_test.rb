require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid save user" do
    user = User.new(name: "Valid Name",
                    username: "valid_username",
                    password: "password123",
                    password_confirmation: "password123")
    assert user.save
  end

  test "should not save when invalid username" do
    user = User.new(name: "Valid Name",
                    username: "invalid username",
                    password: "password123",
                    password_confirmation: "password123")
    assert_not user.save
  end

  test "should not save when username is less than 5 characters" do
    user = User.new(name: "Valid Name",
                    username: "1234",
                    password: "password123",
                    password_confirmation: "password123")
    assert_not user.save
  end

  test "should not save when no username" do
    user = User.new(name: "Valid Name",
                    password: "password123",
                    password_confirmation: "password123")
    assert_not user.save
  end

  test "should not save when unmatching password_confirmation" do
    user = User.new(name: "Valid Name",
                    username: "valid_username",
                    password: "password123",
                    password_confirmation: "password1234")
    assert_not user.save
  end

  test "should not save when no password_confirmation" do
    user = User.new(name: "Valid Name",
                    username: "valid_username",
                    password: "password123")
    assert_not user.save
  end
end
