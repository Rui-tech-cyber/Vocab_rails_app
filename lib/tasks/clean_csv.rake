require "csv"

namespace :words do
  desc "words.csv から単語を DB に読み込む"
  task import_csv: :environment do
    file_path = Rails.root.join("db", "words.csv")
    count = 0

    default_book = WordBook.first || WordBook.create!(title: "インポート用", user: User.first, dummy: true)

    CSV.foreach(file_path, headers: true, liberal_parsing: true) do |row|
      term    = row["term"].to_s.strip
      meaning = row["meaning"].to_s.strip
      example = row["example"].to_s.strip

      next if term.blank? || meaning.blank?

      word = ::Word.find_or_initialize_by(term: term, meaning: meaning, word_book: default_book)
      word.example = example
      word.save!
      count += 1
    end

    puts "#{count} 件の単語を DB に追加しました。"
  end
end
