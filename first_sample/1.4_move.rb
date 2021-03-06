class Customer
  def statement
    total_amount, frequent_renter_points = 0, 0
    result = "Rental Record for #{@name}"
    @rentals.each do |element|

      # レンタルポイントを加算
      frequent_renter_points += 1
      # 新作2日間のレンタルでポーナスポイント加算
      if element.movie.price_code == Movie.NEW_REEASE && element.days_rented > 1
        frequent_renter_points += 1
      end

      result += "\t" + element.movie.title + "\t" + element.charge.to_s + "\t"
      total_amount += element.charge
    end

    result += "Amount owed is #{total_amount}"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result
  end
end


class Rantal
  def charge
    result = 0
    case movie.price_code
    when Movie::REGULAR
      result += 2
      result += (days_rented - 2) * 1.5 if days_rented > 2
    when Movie::NEW_RELEASE
      result += days_rented * 3
    when Movie::CHILDRENS
      result += 1.5
      result += (days_rented - 3) * 1.5 if days_rented > 3
    end
    result
  end

  def frequent_renter_points
    element.movie.price_code == Movie.NEW_REEASE && element.days_rented > 1 ? 2 :1
  end
end