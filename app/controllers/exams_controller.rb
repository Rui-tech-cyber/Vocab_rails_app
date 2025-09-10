class ExamsController < ApplicationController
  before_action :authenticate_user!

  def new
    @word_book = WordBook.find(params[:word_book_id])
    @word_book.exam&.destroy
    @exam = Exam.create!(user: current_user, word_book: @word_book)

    @word_book.words.each do |word|
      @exam.exam_questions.create!(
        word: word,
        question_text: "[#{word.term}]の意味は？"
      )
    end

    redirect_to exam_path(@exam)
  end

  def show
    @exam = Exam.find(params[:id])
    @questions = @exam.exam_questions.includes(:word)
  end

  def result
    @exam = Exam.find(params[:id])
    @answers = @exam.exam_answers.includes(:word)

    @correct_count = @answers.select(&:correct).count
    @incorrect_count = @answers.size - @correct_count
  end
end
