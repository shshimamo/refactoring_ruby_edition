# evalを使わなければならないが、evalの実行回数を減らしたい
# => メソッド定義の中でevalを使うのではなくメソッドを定義するときに使う


class Person_before
  def self.attr_with_default(options)
    options.each_pair do |attribute, default_value|
      define_method attribute do 
        eval "@#{attribute} ||= #{default_value}"
      end
    end
  end

  attr_with_default emails: "[]",
                    employee_number: "EmployeeNumberGenerator.next" 
end

class EmployeeNumberGenerator
  def self.next
    @@id ||= 0
    @@id += 1
  end
end

# =>

require 'pry'
require 'pry-byebug'

class Person
  def self.attr_with_default(options)
    options.each_pair do |attribute, default_value|
      eval "define_method :#{attribute} do
           @#{attribute} ||= #{default_value}
           end"
    end
  end

  attr_with_default :emails => "[]",
                    :employee_number => "EmployeeNumberGenerator.next" 
end

