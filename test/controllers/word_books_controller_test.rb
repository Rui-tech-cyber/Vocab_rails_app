require "test_helper"

class WordBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get word_books_index_url
    assert_response :success
  end

  test "should get show" do
    get word_books_show_url
    assert_response :success
  end

  test "should get new" do
    get word_books_new_url
    assert_response :success
  end

  test "should get create" do
    get word_books_create_url
    assert_response :success
  end
end
