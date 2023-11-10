require "test_helper"

class PlaceholderControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get placeholder_welcome_url
    assert_response :success
  end
end
