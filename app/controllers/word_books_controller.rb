class WordBooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wordbook, only: [:show, :edit, :update, :destroy]

  def index
    @word_books = current_user.word_books.order(created_at: :desc)
  end

  def show
    @words = @word_book.words.order(created_at: :desc)
  end

  def new
    @word_book = current_user.word_books.new
  end

  def create
    @word_book = current_user.word_books.new(word_book_params)
    if @word_book.save
      redirect_to word_books_path, notice: "#{@word_book.title}を作成しました。"
    else
      flash.now[:alert] = "作成に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update
    if @word_book.update(word_book_params)
      redirect_to @word_book, notice: "#{@word_book.title}を更新しました。"
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    if @word_book
      @word_book.destroy
      redirect_to word_books_path, notice: "#{@word_book.title}を削除しました。"
    else
      redirect_to word_books_path, alert: "削除できませんでした。"
    end
  end

  private

  def set_wordbook
    @word_book = current_user.word_books.find_by(id: params[:id])
    unless @word_book
      redirect_to word_books_path, alert: "この単語帳にはアクセスできません。"
    end
  end

  def word_book_params
    params.require(:word_book).permit(:title)
  end
end
