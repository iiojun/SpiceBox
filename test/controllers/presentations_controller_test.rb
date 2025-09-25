require "test_helper"

class PresentationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get presentations_show_url
    assert_response :success
  end
end
