# 一度だけ代入されている一時変数を取り除く
base_price = an_order.base_price
return (base_price > 1000)

# =>

return (an_order.base_price > 1000)
