require "net/http"
require "json"

class WordsController < ApplicationController
  before_action :authenticate_user!, except: [:search]
  before_action :set_word_book_for_nested, only: [:new, :edit, :update, :destroy]
  before_action :set_word, only: [:edit, :update, :destroy]

  def new
    @word = @word_book.words.new
  end

  def create
    word_book_id = params[:word][:word_book_id] || params[:word_book_id]
    @word_book = current_user.word_books.find(word_book_id)
    @word = @word_book.words.new(word_params.except(:word_book_id))

    if @word.save
      redirect_to word_book_path(@word_book), notice: "単語を追加しました。"
    else
      redirect_back fallback_location: word_books_path, alert: "単語の追加に失敗しました。"
    end
  end  

  def edit; end

  def update
    if @word.update(word_params.except(:word_book_id))
      redirect_to word_book_path(@word_book), notice: "単語を更新しました。"
    else
      flash.now[:alert] = "単語の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @word.destroy
    redirect_to word_book_path(@word_book), notice: "単語を削除しました。"
  end

  def search
    @results = []

    if params[:term].present?
      term = params[:term].to_s.strip

      if term.match?(/[^a-zA-Z]/)
        flash.now[:alert] = "検索は英単語のみ対応しています。"
        return render :search
      end

      begin
        url = URI("https://api.dictionaryapi.dev/api/v2/entries/en/#{term}")
        res = Net::HTTP.get(url)
        data = JSON.parse(res)
        data = [] unless data.is_a?(Array)

        @results = data.map do |entry|
          {
            word: entry["word"] || "不明な単語",
            meaning: entry.dig("meanings", 0, "definitions", 0, "definition") || "意味なし",
            example: entry.dig("meanings", 0, "definitions", 0, "example") || "例文なし"
          }
        end
      rescue JSON::ParserError, Errno::ECONNREFUSED, Net::OpenTimeout, NoMethodError => e
        flash.now[:alert] = "API取得中にエラーが発生しました: #{e.message}"
      end
    end

    render :search
  end

  private

  def set_word_book_for_nested
    @word_book = current_user.word_books.find_by(id: params[:word_book_id])
    unless @word_book
      redirect_to word_books_path, alert: "この単語帳にはアクセスできません。"
    end
  end

  def set_word
    @word = @word_book.words.find(params[:id])
  end

  def word_params
    params.require(:word).permit(:term, :meaning, :example, :word_book_id)
  end
end
