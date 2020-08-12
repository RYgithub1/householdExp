require "householdExp"
require "thor"
require "mechanize"
require "nokogiri"
require "kconv"
require "selenium-webdriver"


module HouseholdExp
  class CLI < Thor

    # ----- make cli first -----
    # コマンドの使用例と概要の説明
    desc "color word1 word3 word3", "words colored by red blue green print."
    # メソッドとして定義
    def color(word1, word2, word3)
      say(word1, :red)
      say(word2, :blue)
      say(word3, :green)
    end

    desc "hello NAME", "say hello to NAME"
    option :from, type: :string, default: "none"
    def hello(name)
      # puts "Hello #{name}"
      puts "Hello #{name} from #{options[:from]}"
    end

    desc "snake2camel snake_case_string", "convert {snake_case_string} to {SnakeCaseString}"
    def snake2camel(str)
      puts str.split("_").map{|w| w[0] = w[0].upcase; w}.join
    end

    desc "camel2snake CamelCaseString", "convert {CamelCaseString} to {camel_case_string}"
    def camel2snake(str)
      puts str
        .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .tr("-", "_")
        .downcase
    end

    desc "oddcheck number", "answer odd or any"
    def oddcheck(number)
      number = number.to_i
      if number < 0 then
        number = number * (-1)
      end
      if number%2 == 1 then
        puts 'Integer part is odd'
      else
        puts 'Integer part is not odd'
      end
    end


    # ==== セレニウムに変更 ==================
    desc "zaim mail password yyyymm", "expenses of a month(YYYYMM)"
    def zaim(mailZaim, passwordZaim, monthZaim)
      # インスタンス生成
      driver = Selenium::WebDriver.for :chrome


      # ブラウザ起動
      urlAuth = "https://auth.zaim.net/"
      driver.get urlAuth
      # ログイン
      driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[2]/div/input').send_keys mailZaim
      driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[3]/div/input').send_keys passwordZaim
      driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[4]/input').click
      sleep 1
      # yyyymmの履歴に遷移
      urlHistory = "https://zaim.net/money?month=#{monthZaim}"
      driver.get urlHistory
      sleep 1
      puts "\n\n"
      puts "  ∩ ∩ 　＜ 収支サマリ（#{monthZaim}）♪ ）"
      puts "（・×・）————————————————————————————————————"
      puts driver.find_element(:tag_name, 'table').text
      puts "———————————————————————————————————————————"
      sleep 1
      puts "\n"
      puts "\n"
      puts "ーー 履歴ページ ーー"

      puts "【日付 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[1]/div[3]/span').text
      puts "【ｶﾃｺﾞﾘ】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div["#{row}"]/div[4]/span[2]').text
      puts "【金額 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div["#{row}"]/div[5]/span').text
      puts "【出金 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div["#{row}"]/div[6]').text
      puts "【入金 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div["#{row}"]/div[7]').text
      puts "【お店 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div["#{row}"]/div[8]/span').text
      puts "【品目 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div["#{row}"]/div[9]/span').text
      puts "【メモ 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div["#{row}"]/div[10]/span').text
      puts "\n"
      # ーーーーーーーーーーーー
      puts "【日付 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[2]/div[3]/span').text
      puts "【ｶﾃｺﾞﾘ】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[2]/div[4]/span[2]').text
      puts "【金額 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[2]/div[5]/span').text
      puts "【出金 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[2]/div[6]').text
      puts "【入金 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[2]/div[7]').text
      puts "【お店 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[2]/div[8]/span').text
      puts "【品目 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[2]/div[9]/span').text
      puts "【メモ 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[2]/div[10]/span').text
      puts "\n"
      # ーーーーーーーーーーーー
      puts "【日付 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[3]/div[3]/span').text
      puts "【ｶﾃｺﾞﾘ】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[3]/div[4]/span[2]').text
      puts "【金額 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[3]/div[5]/span').text
      puts "【出金 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[3]/div[6]').text
      puts "【入金 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[3]/div[7]').text
      puts "【お店 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[3]/div[8]/span').text
      puts "【品目 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[3]/div[9]/span').text
      puts "【メモ 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[3]/div[10]/span').text
      puts "\n"
      # ーーーーーーーーーーーー
      puts "【日付 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[4]/div[3]/span').text
      puts "【ｶﾃｺﾞﾘ】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[4]/div[4]/span[2]').text
      puts "【金額 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[4]/div[5]/span').text
      puts "【出金 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[4]/div[6]').text
      puts "【入金 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[4]/div[7]').text
      puts "【お店 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[4]/div[8]/span').text
      puts "【品目 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[4]/div[9]/span').text
      puts "【メモ 】" + driver.find_element(:xpath, '/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[4]/div[10]/span').text
      puts "\n"
    

      # ブラウザ終了
      puts "\n"
      puts "  ∩ ∩ 　＜ ご確認頂きありがとうございます！ ）"
      puts "（・▽・）————————————————————————————————————"
      puts "\n"
      driver.quit
    end


  end
end
