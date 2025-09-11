require "csv"

class Dictionary
  FILE_PATH = Rails.root.join("db/dictionaries/words.csv")

  def self.search(term)
    results = []
    CSV.foreach(FILE_PATH, headers: true) do |row|
      if row["term"].downcase == term.downcase
        results << {
          word: row["term"],
          meaning: row["meaning"],
          example: row["example"]
        }
      end
    end
    results
  end
end
