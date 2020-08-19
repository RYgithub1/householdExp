require "selenium-webdriver"


RSpec.describe HouseholdExp do
  describe "RSpec_Application_Test" do

    describe "#version" do
      it "has a version number" do
        expect(HouseholdExp::VERSION).not_to be nil
      end
    end

    describe "cli_年月有効性" do
      context "桁数確認" do
        it "【right】mail/password <-> 【wrong】month（桁数6：123456789）" do
          monthZaim = "123456789"
          expect(monthZaim.length).not_to eq 6
        end
      end
      context "年月確認" do
        it "【right】mail/password <-> 【wrong】month（mm：1月〜12月）" do
          monthZaim = "202099"
          monthZaimInt = monthZaim.to_i
          lastTwoDigits = monthZaimInt % 100
          expect(lastTwoDigits >= 1 && lastTwoDigits <= 12).to be false
        end
        it "【right】mail/password <-> 【wrong】month（yyyy：0100年〜9999年）" do
          monthZaim = "000099"
          monthZaimInt = monthZaim.to_i
          firstFourDigitsFloor = monthZaimInt / 100
          firstFourDigits = firstFourDigitsFloor.floor
          expect(firstFourDigits >= 100 && firstFourDigits).to be false
        end
      end
    end

    describe "#cli_ログイン" do
      context "ログイン可能な場合" do
        it "【right】mail/password <-> 【wrong】" do
          mailZaim = "householdExpenses316@gmail.com"
          passwordZaim = "expense3"
          driver = Selenium::WebDriver.for :chrome
          urlAuth = "https://auth.zaim.net/"
          driver.get urlAuth
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[2]/div/input').send_keys mailZaim
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[3]/div/input').send_keys passwordZaim
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[4]/input').click
          sleep 1
          urlLogin = "https://zaim.net/home"
          expect(driver.current_url).to eq urlLogin
          driver.quit
        end
      end
      context "ログイン不可の場合" do
        it "【right】mail <-> 【wrong】password" do
          mailZaim = "householdExpenses316@gmail.com"
          passwordWrong = "zzzzzzz3"
          driver = Selenium::WebDriver.for :chrome
          urlAuth = "https://auth.zaim.net/"
          driver.get urlAuth
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[2]/div/input').send_keys mailZaim
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[3]/div/input').send_keys passwordWrong
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[4]/input').click
          sleep 1
          expect(driver.current_url).to eq urlAuth
          driver.quit
        end
        it "【right】password <-> 【wrong】mail" do
          mailWrong = "zzzzzzzzzzzzzzzzzzzz@zzzzz.com"
          passwordZaim = "expense3"
          driver = Selenium::WebDriver.for :chrome
          urlAuth = "https://auth.zaim.net/"
          driver.get urlAuth
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[2]/div/input').send_keys mailWrong
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[3]/div/input').send_keys passwordZaim
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[4]/input').click
          sleep 1
          expect(driver.current_url).to eq urlAuth
          driver.quit
        end
        it "【right】 <-> 【wrong】mail/password" do
          mailWrong = "zzzzzzzzzzzzzzzzzzzz@zzzzz.com"
          passwordWrong = "zzzzzzz3"
          driver = Selenium::WebDriver.for :chrome
          urlAuth = "https://auth.zaim.net/"
          driver.get urlAuth
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[2]/div/input').send_keys mailWrong
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[3]/div/input').send_keys passwordWrong
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[4]/input').click
          sleep 1
          expect(driver.current_url).to eq urlAuth
          driver.quit
        end
      end
    end

    describe "#cli_履歴有無" do
      context "記録有りの場合" do
        it "【right】mail/password/month（202008） <-> 【wrong】" do
          mailZaim = "householdExpenses316@gmail.com"
          passwordZaim = "expense3"
          monthZaim = "202008"
          isLogText = "金融連携が入出金先に指定されている入力を追加・編集すると残高が狂うことがあります。サポート対象外となりますので、ご自分で残高の調整をお願いいたします。 メモなどが見えない場合は、表を横にスクロールしてください。"
          driver = Selenium::WebDriver.for :chrome
          urlAuth = "https://auth.zaim.net/"
          driver.get urlAuth
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[2]/div/input').send_keys mailZaim
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[3]/div/input').send_keys passwordZaim
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[4]/input').click
          sleep 1
          urlHistory = "https://zaim.net/money?month=#{monthZaim}"
          driver.get urlHistory
          sleep 1
          expect(driver.find_element(:xpath, "/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[1]").text).to eq isLogText
          driver.quit
        end
      end
      context "記録無しの場合" do
        it "【right】mail/password/month（202007） <-> 【wrong】" do
          mailZaim = "householdExpenses316@gmail.com"
          passwordZaim = "expense3"
          monthZaim = "202007"
          noLogText = "この月には、まだ記録がありませんでした。上部にある左右の矢印から前後の月に移動してください。"
          driver = Selenium::WebDriver.for :chrome
          urlAuth = "https://auth.zaim.net/"
          driver.get urlAuth
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[2]/div/input').send_keys mailZaim
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[3]/div/input').send_keys passwordZaim
          driver.find_element(:xpath, '/html/body/div[3]/div[2]/div[1]/div[2]/form/div[4]/input').click
          urlHistory = "https://zaim.net/money?month=#{monthZaim}"
          sleep 1
          driver.get urlHistory
          sleep 1
          expect(driver.find_element(:class, 'HistorySearch-module__bodyArea___3AbtF').text).to eq noLogText
          driver.quit
        end
      end
    end
  end
end
