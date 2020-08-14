require "selenium-webdriver"


RSpec.describe HouseholdExp do
  describe "RSpec_Application_Test" do

    describe "#version" do
      it "has a version number" do
        expect(HouseholdExp::VERSION).not_to be nil
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
      context "ログイン不可な場合" do
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

    describe "#cli_履歴表示" do
      context "入力月が有効な場合" do
        it "【right】mail/password/month(記録有り：202008) <-> 【wrong】" do
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
          urlHistory = "https://zaim.net/money?month=#{monthZaim}"
          driver.get urlHistory
          sleep 2
          expect(driver.find_element(:xpath, "/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[1]").text).to eq isLogText
          driver.quit
        end
        it "【right】mail/password/month(記録無し：202007) <-> 【wrong】" do
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
          driver.get urlHistory
          sleep 2
          expect(driver.find_element(:class, 'HistorySearch-module__bodyArea___3AbtF').text).to eq noLogText
          driver.quit
        end
      end
      context "入力月が無効な場合" do
        it "【right】mail/password <-> 【wrong】month(桁：123456789)" do
    
        end
        it "【right】mail/password <-> 【wrong】month(年月：777777)" do
        
        end
      end
    end
  end
end
