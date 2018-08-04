require 'set'

class Customer
  def initialize
    @orders = Set.new
  end

  def friend_orders
    @orders
  end

  def add_order(order)
    order.customer = self # orderに自分をセット
  end
end

class Order
  attr_reader :customer

  def customer=(value)
    customer.friend_orders.subtract(self) unless customer.nil? # 古いcustomerから自分を引く
    @customer = value
    customer.friend_orders.add(self) unless customer.nil? # 新しいcustomerに自分を追加
  end
end

# orderが多数のcustomerをモテる場合は多対多関係になる
# (コード省略)
