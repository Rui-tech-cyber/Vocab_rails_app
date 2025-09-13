class ExamAnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    exam = Exam.find(params[:exam_id])
    answers = params[:answers] || {}
    mode = params[:mode]

    if answers.empty?
      redirect_to exam_path(exam), alert: "回答が入力されていません。"
      return
    end

    answers.each do |question_id, answer_text|
      question = ExamQuestion.find(question_id)

      correct =
        if mode == "jp_to_en" || exam.jp_to_en?
          answer_text.to_s.strip.downcase == question.word.term.to_s.strip.downcase
        else
          answer_text.to_s.strip.downcase == question.word.meaning.to_s.strip.downcase
        end

      exam_answer = ExamAnswer.find_or_initialize_by(
        exam: exam,
        word: question.word,
        user: current_user
      )
      exam_answer.user_answer = answer_text
      exam_answer.correct = correct
      exam_answer.save!

      question.word.update!(mistake: !correct)
    end

    redirect_to result_exam_path(exam), notice: "回答を送信しました。"
  end
end
