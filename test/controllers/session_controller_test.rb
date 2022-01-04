require "test_helper"

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get session_login_url
    assert_response :success
  end

  test "should get create" do
    get session_create_url
    assert_response :redirect
  end
end
