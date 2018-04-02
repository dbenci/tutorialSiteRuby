require 'test_helper'

class UtilitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get enterButton" do
    get utilities_enterButton_url
    assert_response :success
  end

end
