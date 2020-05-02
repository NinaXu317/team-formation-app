require 'test_helper'

class CreateAccountTest < ActionDispatch::IntegrationTest

        test "can create student account" do
                get "/students/new"
                assert_response :success
                post "/students",
                params: {student: {firstname: "John", lastname: "Doe", 
                        email: "example@example.com", password: "password",
                        password_confirmation: "password"}}
                assert_response :redirect
                follow_redirect!
                assert_response :success
        end

        test "can create professor account" do
                get "/professors/new"
                assert_response :success
                post "/professors",
                params: {professor: {firstname: "John", lastname: "Doe", 
                        email: "example@example.com", password: "password",
                        password_confirmation: "password"}}
                assert_response :redirect
                follow_redirect!
                assert_response :success
        end


end
