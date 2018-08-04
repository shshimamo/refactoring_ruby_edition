def print_owing
  outstanding = 0.0
  print_banner
  @orders.each do |order|
    outstanding += order.amount
  end
  print_details outstanding
end

# =>

def print_owing
  print_banner
  outstanding = calculate_outstanding
  print_details outstanding
end

def calculate_outstanding
  @orders.inject(0.0) { |result, order| result + order.amount }
end
