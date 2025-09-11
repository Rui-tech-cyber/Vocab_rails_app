namespace :csv do
  desc "重複を削除してCSVをクリーン化する"
  task clean: :environment do
    require "csv"

    input_path = Rails.root.join("db/words.csv")
    output_path = Rails.root.join("db/words_clean.csv")

    seen = {}
    cleaned = []

    CSV.foreach(input_path, headers: true) do |row|
      key = row["word"].downcase.strip
      next if seen[key] # 重複はスキップ

      seen[key] = true
      cleaned << row
    end

    CSV.open(output_path, "w") do |csv|
      csv << cleaned.first.headers
      cleaned.each { |row| csv << row }
    end

    puts "✅ Cleaned CSV saved to #{output_path}"
  end
end
