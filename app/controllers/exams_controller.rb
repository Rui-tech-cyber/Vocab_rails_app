class ExamsController < ApplicationController
  before_action :authenticate_user!

  def new
    @word_book = WordBook.find(params[:word_book_id])
    @word_book.exam&.destroy

    mode = params[:mode] || "en_to_jp"

    @exam = Exam.create!(user: current_user, word_book: @word_book, mode: mode)

    @word_book.words.each do |word|
      question_text = 
      if @exam.en_to_jp?
        "[#{word.term}]の意味は？"
      else
        "[#{word.meaning}]の英単語は？"
      end

      @exam.exam_questions.create!(
        word: word,
        question_text: question_text
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
