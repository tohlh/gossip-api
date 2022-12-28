require "test_helper"

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  test "user signup" do
    post('/auth/signup',
         params: {:name => "Some User",
                  :username => "someuser",
                  :password => "supersecret",
                  :password_confirmation => "supersecret"})
    assert_response :created
  end

  test "user signup password unmatched" do
    post('/auth/signup',
         params: {:name => "Some User",
                  :username => "someuser",
                  :password => "supersecret1",
                  :password_confirmation => "supersecret2"})
    assert_response :bad_request
  end

  test "user signup invalid username" do
    post('/auth/signup',
         params: {:name => "Some User",
                  :username => "invalid username",
                  :password => "supersecret",
                  :password_confirmation => "supersecret"})
    assert_response :bad_request
  end

  test "user login" do
    post('/auth/signup',
         params: {:name => "Some User",
                  :username => "someuser",
                  :password => "supersecret",
                  :password_confirmation => "supersecret"})
    post('/auth/login',
         params: {:username => "someuser",
                  :password => "supersecret"})
    assert_response :ok
  end

  test "user login wrong password" do
    post('/auth/signup',
         params: {:name => "Some User",
                  :username => "someuser",
                  :password => "supersecret",
                  :password_confirmation => "supersecret"})
    post('/auth/login',
         params: {:username => "someuser",
                  :password => "wrongsupersecret"})
    assert_response :unauthorized
  end

  test "username taken" do
    post('/auth/signup',
         params: {:name => "Some User 1",
                  :username => "someuser",
                  :password => "supersecret1",
                  :password_confirmation => "supersecret1"})
    post('/auth/signup',
         params: {:name => "Some User 2",
                  :username => "someuser",
                  :password => "supersecret2",
                  :password_confirmation => "supersecret2"})
    assert_response :bad_request
  end
end
