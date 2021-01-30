#csvファイルを扱うために必要な記述
require 'csv'

  namespace :import_csv do
    desc "CSVデータをインポートするタスク"
    task users: :environment do
      path = "db/csv_data/csv_data.csv"
      list = []
      CSV.foreach(path, headers: true) do |row|
        list << row.to_h
      end
      puts "インポート処理開始"
      begin
      User.transaction do 
        User.create!(list)
      end
        puts "インポート完了!!".green
      rescue StandardError => e
        #例外が発生した時の処理
        #インポートができなかった時の処理
        puts "#{e.class}: #{e.message}".red
        puts "------------------------"
        puts e.backtrace #例外が発生した位置情報
        puts "------------------------"
        puts "インポートに失敗".red
    end
  end
end
