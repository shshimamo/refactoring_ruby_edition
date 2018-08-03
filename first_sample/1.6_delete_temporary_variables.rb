class Customer
  def statement
    result = "Rental Record for #{@name}"
    @rentals.each do |element|
      # このレンタルの料金を表示
      result += "\t" + element.movie.title + "\t" + element.charge.to_s + "\t"
    end

    # フッターを追加
    result += "Amount owed is #{total_charge}"
    result += "You earned #{total_frequent_renter_points} frequent renter points"
    result
  end

  private

  # パフォーマンスよりもまずコードをわかりやすくしてからプロファイラを使ってパフォーマンス問題に取り組むべし
  def total_charge
    @rentals.inject(0) {|sum, rental| sum + rental.charge}
  end

  def total_frequent_renter_points
    @rentals.inject(0) {|sum, rental| sum + rental.frequent_renter_points}
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
    movie.price_code == Movie.NEW_REEASE && element.days_rented > 1 ? 2 :1
  end
end