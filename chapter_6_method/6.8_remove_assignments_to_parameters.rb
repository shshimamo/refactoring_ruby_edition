# 引数がまったく別のオブジェクトを参照するようになることはNG

def discount(input_val, quantity, year_to_date)
  input_val -= 2 if input_val > 50
  input_val -= 1 if quantity > 100
  input_val -= 4 if year_to_date > 10000
  input_val
end

# 引数を一時変数に置き換える
# =>

def discount(input_val, quantity, year_to_date)
  result = input_val
  result -= 2 if input_val > 50
  result -= 1 if quantity > 100
  result -= 4 if year_to_date > 10000
  result
end


##########
# 値渡しと参照渡し
# ポイント
#   Rubyは値渡し
#   変数が参照(=メモリ番地)を保持している場合は、それが引数にコピーされる
#   そのため変数(実引数)と引数(仮引数)とが同じオブジェクトを共有することになるので引数が示すオブジェクトを変更するともとの変数のオブジェクトも変更される
#   変数を変更することと変数が示すオブジェクトを変更することは別である

class Ledger
  attr_reader :balance
  def initialize(balance)
    @balance = balance
  end
  def add(arg)
    @balance += arg
  end
end

class Product
  def self.add_price_by_updating(ledger, price)
    ledger.add(price)
    puts "#{ledger.balance}"
  end
  def self.add_price_by_replacing(ledger, price)
    ledger = Ledger.new(ledger.balance + price)
    puts "#{ledger.balance}"
  end
end

l1 = Ledger.new(0)
Product.add_price_by_updating(l1, 5) # 5
puts "#{l1.balance}" # 5

l2 = Ledger.new(0)
Product.add_price_by_replacing(l2, 5) # 5
puts "#{l2.balance}" # 0
