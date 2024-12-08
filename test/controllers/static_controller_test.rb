require "test_helper"

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "should get console" do
    get static_console_url
    assert_response :success
  end
end
