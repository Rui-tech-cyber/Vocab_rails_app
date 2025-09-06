require "net/http"
require "json"

class WordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_word_book, except: [:search]
  before_action :set_word, only: [:edit, :update, :destroy]

  def new
    @word = @word_book.words.new
  end

  def create
    @word = @word_book.words.new(word_params)
    if @word.save
      redirect_to word_book_path(@word_book), notice: "単語を追加しました。"
    else
      flash.now[:alert] = "単語の追加に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update(word_params)
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
        return
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
  end

  private

  def set_word_book
    @word_book = current_user.word_books.find_by(id: params[:word_book_id])
    unless @word_book
      redirect_to word_books_path, alert: "この単語帳にはアクセスできません。"
    end
  end

  def set_word
    @word = @word_book.words.find(params[:id])
  end

  def word_params
    params.require(:word).permit(:term, :meaning, :example)
  end
end
