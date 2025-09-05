class WordsController < ApplicationController
  require "net/http"
  require "json"

  def search
    if params[:term].present?
      term = params[:term]
      url = URI("https://api.dictionaryapi.dev/api/v2/entries/en/#{term}")
      res = Net::HTTP.get(url)
      data = JSON.parse(res) rescue []

      @results = data.map do |entry|
        {
          word: entry["word"],
          meaning: entry.dig("meanings", 0, "definitions", 0, "definition"),
          example: entry.dig("meanings", 0, "difinitions", 0, "example")
        }
      end
    end
  end
end
