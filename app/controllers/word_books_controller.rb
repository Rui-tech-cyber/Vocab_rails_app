class WordBooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @wordbooks = current_user.wordbook.order(created_at: :desc)
  end

  def show
    @wordbook = current_user.wordbooks.find(params[:id])
    @words = @wordbook.word.order(created_at: :desc)
  end

  def new
    @wordbook = current_user.wordbooks.new
  end

  def create
    @wordbook = current_user.wordbooks.new(wordbook_params)
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
