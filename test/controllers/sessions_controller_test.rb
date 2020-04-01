require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get student_login" do
    get student_login_path
    assert_response :success
  end

  test "should get logout" do
    get logout_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

end
