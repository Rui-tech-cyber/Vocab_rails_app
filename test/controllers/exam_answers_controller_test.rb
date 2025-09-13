require "test_helper"

class ExamAnswersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get exam_answers_create_url
    assert_response :success
  end
end
