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
    movie.charge(days_rented)
  end

  def frequent_renter_points
    movie.frequent_renter_points(days_rented)
  end
end

# (ポイント)
# タイプコードからState/Strategyへ(これはStateパターン)
# タイプ変数(price_code) => 料金クラス(xxPrice)

# 呼び出し方
# movie = Movie.new("The Watchmen", NewReleasePrice.new)
# それ以降
# movie.price = Movie::REGULAR
class Movie
  attr_writer :price

  def initialize(title, price)
    @title, self.price = title, price
  end

  def charge(days_rented)
    @price.charge(days_rented)
  end

  def frequent_renter_points(days_rented)
    @price.frequent_renter_points(days_rented)
  end
end

module DefaultPrice
  def frequent_renter_points(days_rented)
    1
  end
end

class RegularPrice
  include DefaultPrice
  def charge(days_rented)
    result = 2
    result += (days_rented - 2) * 1.5 if days_rented > 2
    result
  end
end

class NewReleasePrice
  def charge(days_rented)
    days_rented * 3
  end

  def frequent_renter_points(days_rented)
    days_rented > 1 ? 2 :1
  end
end

class ChildrensPrice
  include DefaultPrice
  def charge(days_rented)
    result = 1.5
    result += (days_rented - 3) * 1.5 if days_rented > 3
    result
  end
end