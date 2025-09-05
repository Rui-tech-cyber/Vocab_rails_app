class WordsController < ApplicationController
  require "net/http"
  require "json"

  def search
    @results = []

    if params[:term].present?
      term = params[:term].to_s.strip

      if term.match?(/[^a-zA-Z]/)
        flash.now[:alert] = "検索は英単語のみ対応しています"
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
end
