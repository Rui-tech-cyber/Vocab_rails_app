class WordBooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @wordbooks = current_user.word_books.order(created_at: :desc)
  end

  def show
    @wordbook = current_user.word_books.find(params[:id])
    @words = @wordbook.words.order(created_at: :desc)
  end

  def new
    @wordbook = current_user.word_books.new
  end

  def create
    @wordbook = current_user.word_books.new(wordbook_params)
    if @wordbook.save
      redirect_to wordbooks_path, notice: "単語帳を作成しました。"
    else
      flash.now[:alert] = "作成に失敗しました。"
      render :new
    end
  end

  private

  def wordbook_params
    params.require(:wordbook).permit(:title)
  end
end
