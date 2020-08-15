require "householdExp"
require "thor"
require "mechanize"
require "nokogiri"
require "kconv"
require "selenium-webdriver"
require "rubygems"


module HouseholdExp
  class CLI < Thor

    # コマンドと概要
    desc "zaim mail password yyyymm", "expenses of a month(YYYYMM)"
    # メソッド定義
    def zaim(mailZaim, passwordZaim, monthZaim)

      # 年月有効性（桁数6）
      unless monthZaim.length == 6
        puts "\ncheck valid numbers（yyyymm）\n\n"
        exit
      end
      # 年月有効性__自然数
      monthZaimInt = monthZaim.to_i
      # 年月有効性（下2桁）
      lastTwoDigits = monthZaimInt % 100
      unless lastTwoDigits >= 1 && lastTwoDigits <= 12 then
        puts "\ncheck valid month（01 <= mm <= 12）\n\n"
        exit
      end
      # 年月有効性（上4桁）
      firstFourDigitsFloor = monthZaimInt / 100
      firstFourDigits = firstFourDigitsFloor.floor
      unless firstFourDigits >= 100 && firstFourDigits <= 9999 then
        puts "\ncheck valid year（0100 <= yyyy <= 9999）\n\n"
        exit
      end

      # インスタンス生成（ヘッドレスブラウザ）
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      driver = Selenium::WebDriver.for :chrome, options: options

      # ブラウザ起動
      urlAuth = "https://auth.zaim.net/"
      driver.get urlAuth

      # ログイン
      driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[2]/div/input').send_keys mailZaim
      driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[3]/div/input').send_keys passwordZaim
      driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[4]/input').click
      sleep 1

      urlLogin = "https://zaim.net/home"
      currentUrl = driver.current_url
      if currentUrl == urlLogin then
        # 《ログイン成功》
        # 履歴ページ遷移（yyyymm）
        urlHistory = "https://zaim.net/money?month=#{monthZaim}"
        driver.get urlHistory

        # 取得・表示
        puts "\n\n"
        noLogCheck = "この月には、まだ記録がありませんでした。上部にある左右の矢印から前後の月に移動してください。"
        if noLogCheck == driver.find_element(:class, 'HistorySearch-module__bodyArea___3AbtF').text then
          puts "    ∩  ∩ ＜ ご指定月(#{monthZaim})では記録なしです。）"
          puts "｡ﾟ(ﾟ´Д｀ﾟ)ﾟ｡—————————————————————————————————\n\n\n"
          puts "  ∩  ∩ ＜ ご記入のほどお願いいたします！ ）"
          puts "(*´ー｀)ﾉ———————————————————————————————————\n\n"
        else
          puts "  ∩ ∩ ＜ ご指定月(#{monthZaim})の収支サマリです♪ ）"
          puts "（・×・）————————————————————————————————————"
          puts driver.find_element(:tag_name, 'table').text
          puts "\n\n  ∩ ∩ ＜ 明細はこちらです♫ ）"
          puts "（・-・）————————————————————————————————————\n"
          numberOfLines = driver.find_elements(:class, 'SearchResult-module__body___1CNGh').count
          row = 1
          while row <= numberOfLines do
            puts "【日付 】" + driver.find_element(:xpath, "/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[#{row}]/div[3]/span").text
            puts "【ｶﾃｺﾞﾘ】" + driver.find_element(:xpath, "/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[#{row}]/div[4]/span[2]").text
            puts "【金額 】" + driver.find_element(:xpath, "/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[#{row}]/div[5]/span").text
            puts "【出金 】" + driver.find_element(:xpath, "/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[#{row}]/div[6]").text
            puts "【入金 】" + driver.find_element(:xpath, "/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[#{row}]/div[7]").text
            puts "【お店 】" + driver.find_element(:xpath, "/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[#{row}]/div[8]/span").text
            puts "【品目 】" + driver.find_element(:xpath, "/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[#{row}]/div[9]/span").text
            puts "【メモ 】" + driver.find_element(:xpath, "/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[#{row}]/div[10]/span").text
            puts "\n-------------------------------------"
            row += 1
          end
          puts "\n\n  ∩ ∩ ＜ ご確認頂きありがとうございます！ ）"
          puts "（・▽・）————————————————————————————————————\n\n"
        end
        # ブラウザ終了（ログイン成功時）
        driver.quit

      else
        # 《ログイン失敗》
        puts "\nLogin error: mail or password.\n\n"
        # ブラウザ終了（ログイン失敗時）
        driver.quit
      end
    end
  end
end
