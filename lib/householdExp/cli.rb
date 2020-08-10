require 'householdExp'
require 'thor'

# require 'nokogiri'
require 'mechanize'


module HouseholdExp
  class CLI < Thor

    # ----- make cli  first -----
    # コマンドの使用例と概要の説明
    desc "red WORD", "words colored by red print."
    # メソッドとして定義
    def red(word)
      say(word, :red)
    end

    desc "blue WORD", "words colored by blue print."
    def blue(word)
      say(word, :blue)
    end

    desc "green WORD", "words colored by green print."
    def green(word)
      say(word, :green)
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
    desc "", ""
    def mechanize
      agent = Mechanize.new
      urlAuth = "https://auth.zaim.net/"
      page = agent.get(urlAuth)
      puts page.body
      # elements = page.search('input')
      # puts elements
      # puts page.links
      # page.links.each do |link|
      #   puts link.text
      #   # 下はhttpのリンク先
      #   puts link.href
      # end
      # text_link = page.link_with(text: 'ログイン')
      # puts text_link
      # href_link = page.link_with(href: 'https://auth.zaim.net/')
      # puts href_link
      # ---------------
      # # puts page.forms
      # id_form = page.form_with(id: 'householdExpenses316@gmail.com')
      # # page.form_with(class: 'class情報')

      # id_form.field_with(name: 'data[User][email]').value = 'householdExpenses316@gmail.com'
      # id_form.field_with(name: 'data[User][password]').value = 'expense3'
      # # id_form.field_with(id: 'id情報').value = '入力値'

      # result_form = agent.submit(id_form)

      # puts result_form.body

      # puts page.at_css('form')

    end


  end
end
