namespace :words do
  desc "重複する (term + meaning) の組み合わせを削除し、1つだけ残す"
  task cleanup_duplicates: :environment do
    duplicates = Word.select(:term, :meaning)
                     .group(:term, :meaning)
                     .having("COUNT(*) > 1")

    duplicates.each do |dup|
      records = Word.where(term: dup.term, meaning: dup.meaning).order(:id)
      # 最初の1件だけ残して残りを削除
      records.offset(1).destroy_all
      puts "Cleaned duplicates for: #{dup.term} (#{dup.meaning})"
    end

    puts "✅ 重複削除完了！"
  end
end
