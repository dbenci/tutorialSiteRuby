require 'test_helper'

class QuizControllerTest < ActionDispatch::IntegrationTest
  test "should get hiragana" do
    get quiz_hiragana_url
    assert_response :success
  end

end
