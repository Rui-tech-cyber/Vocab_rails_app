class HomeController < ApplicationController
  def index
    @latest_word_books = WordBook.order(created_at: :desc).limit(5)
  end
end
