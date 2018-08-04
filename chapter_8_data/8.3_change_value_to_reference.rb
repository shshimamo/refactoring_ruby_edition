# --値から参照へ--

# Customerは値オブジェクト
class Customer
  attr_reader :name
  def initialize(name) # 同じインスタンスをいくつも作る問題
    @name = name
  end
end

class Order
  def initialize(customer_name)
    @customer = Customer.new(customer_name)
  end

  def customer_name
    @customer.name
  end

  def customer=(customer_name)
    @customer = Customer.new(customer_name)
  end
end

# まずコンストラクタからファクトリメソッドへ
# =>

class Customer
  attr_reader :name

  def self.with_name(name) # 
    Instances[name]
  end

  def self.load_customers
    new("Lemon Car Hire").store
    new("Associated Coffee Machines").store
    new("Bilston Gasworks").store
  end

  def store
    Instances[name] = self
  end

  def initialize(name)
    @name = name
  end
end

class Order
  def initialize(customer_name)
    @customer = Customer.with_name(customer_name)
  end
end

