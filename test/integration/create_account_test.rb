require 'test_helper'

class CreateAccountTest < ActionDispatch::IntegrationTest
  test "can create account" do
     get "/students/new"
     assert_response :success
     post "/students",
      params: {student: {firstname: "John", lastname: "Doe", 
              email: "example@example.com", password: "Nellie123",
              password_confirmation: "Nellie123"}}
      assert_response :redirect
      follow_redirect!
      assert_response :success
  end
end
