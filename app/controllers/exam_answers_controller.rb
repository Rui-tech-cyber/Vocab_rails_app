class ExamAnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    exam = Exam.find(params[:exam_id])
    answers = params[:answers] || {}

    if answers.empty?
      redirect_to exam_path(exam), alert: "回答が入力されていません。"
      return
    end

    answers.each do |question_id, answer_text|
      question = ExamQuestion.find(question_id)

      ExamAnswer.create!(
        exam: exam,
        word: question.word,
        user: current_user,
        user_answer: answer_text
      )
    end

    redirect_to exam_path(exam), notice: "回答を送信しました。"
  end
end
