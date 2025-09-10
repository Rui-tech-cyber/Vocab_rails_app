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

      correct = answer_text.to_s.strip.downcase == question.word.meaning.to_s.strip.downcase

      ExamAnswer.create!(
        exam: exam,
        word: question.word,
        user: current_user,
        user_answer: answer_text
        correct: correct
      )

      if !correct
        question.word.update!(mistake: true)
    end
  end

    redirect_to exam_path(exam), notice: "回答を送信しました。"
  end
end
