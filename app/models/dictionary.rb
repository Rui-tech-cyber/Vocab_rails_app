require "csv"

class Dictionary
  CSV_PATH = Rails.root.join("db/words.csv")

  def self.search(term)
    results = []

    CSV.foreach(CSV_PATH, headers: true) do |row|
      word = row["word"].to_s.strip
      meaning = row["meaning"].to_s.strip
      example = row["example"].to_s.strip

      if word.downcase.include?(term.downcase)
        results << { word: word, meaning: meaning, example: example }
      end
    end

    results
  end
end
