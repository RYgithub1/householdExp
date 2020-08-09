require 'householdExp'
require 'thor'

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

  end
end