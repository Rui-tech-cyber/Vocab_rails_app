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

      correct = answer_text.to_s.strip.downcase == question.word.term.to_s.strip.downcase

      exam_answer = ExamAnswer.find_or_initialinze_by(
        exam: exam,
        word: question.word,
        user: current_user
      )
      exam_answer.user_answer = answer_text
      exam_answer.correct = correct
      exam_answer.save!

      question.word.update!(mistake: true) unless correct
    end

    redirect_to result_exam_path(exam), notice: "回答を送信しました。"
  end
end
