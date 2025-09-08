class ExamsController < ApplicationController
  before_action :authenticate_user!

  def new
    @word_book = WordBook.find(params[:word_book_id])
    @exam = @word_book.exams.create!(user: current_user)

    @word_book.words.each do |word|
      @exam.exam_questions.create!(
        word: word,
        question_text: "[#{word.meaning}]に対応する英単語は？"
      )
    end

    redirect_to exam_path(@exam)
  end


  def show
    @exam = Exam.find(params[:id])
    @questions = @exam.exam_questions.includes(:word)
  end
end
