require "csv"

namespace :words do
  desc "words.csv から単語を DB に読み込む"
  task import_csv: :environment do
    file_path = "db/words.csv"
    count = 0

    CSV.foreach(file_path, headers: true, liberal_parsing: true) do |row|
      term = row["term"].to_s.strip
      meaning = row["meaning"].to_s.strip
      example = row["example"].to_s.strip

      next if term.blank? || meaning.blank?

      Word.create(term: term, meaning: meaning, example: example)
      count += 1
    end

    puts "#{count} 件の単語を DB に追加しました。"
  end

  desc "DB の重複単語を整理（term+meaning が同じものは1件だけ残す）"
  task cleanup_duplicates: :environment do
    duplicates = Word.group(:term, :meaning).having("count(*) > 1").pluck(:term, :meaning)
    
    duplicates.each do |term, meaning|
      words = Word.where(term: term, meaning: meaning).order(:id)
      words.offset(1).destroy_all
    end

    puts "重複単語を整理しました。"
  end
end
