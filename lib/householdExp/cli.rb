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

    # ---------------------------
    desc "zaim mail password yyyymm", "expenses of a month(YYYYMM)"
    def zaims(mailZaim, passwordZaim, monthZaim)
      # ----- インスタンス生成 ---------
      agent = Mechanize.new
      agent.user_agent = 'Mac Safari'
      # ----- 認証突破 ---------
      urlAuth = "https://auth.zaim.net/"
      page = agent.get(urlAuth)
      id_form = page.form_with(id: 'UserLoginForm')
      id_form.field_with(name: 'data[User][email]').value = mailZaim
      id_form.field_with(name: 'data[User][password]').value = passwordZaim
      result_form = agent.submit(id_form)
      
      # ----- 履歴突破 ---------
      history_url = "https://zaim.net/money?month=#{monthZaim}"
      # pageHistory = agent.get(history_url).content.toutf8
      pageHistory = agent.get(history_url)

      doc = Nokogiri::HTML(pageHistory.content.toutf8)
  
      doc.xpath("/html/body/div[2]/div[2]/div[1]/div[3]/div/div[2]/div[3]/div[2]/div[2]/div/div[1]/div[5]/span").each do |node|

      end
    end



  end
end
