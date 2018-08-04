def price
  return @quantity * @item_price - [0, @quantity - 500] .max * @item_price * 0.05 + [@quantity * @item_price * 0.1, 100.0].min
end

# =>

def price
  base_price = @quantity * @item_price
  quantity_discount = [0, @quantity - 500] .max * @item_price * 0.05
  shipping = [base_price * 0.1, 100.0].min
  return base_price - quantity_discount + shipping
end

# さらにメソッドの抽出を行うと
# =>

def price
  return base_price - quantity_discount + shipping
end

def base_price
  @quantity * @item_price
end

def quantity_discount
  [0, @quantity - 500] .max * @item_price * 0.05
end

def shipping
  [base_price * 0.1, 100.0].min
end


