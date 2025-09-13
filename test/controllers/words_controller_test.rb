require "test_helper"

class WordsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get words_search_url
    assert_response :success
  end
end
