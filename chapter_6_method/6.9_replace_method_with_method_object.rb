# 所感
# Railsのサービスオブジェクトの考え方と同じ
# おそらくサービスオブジェクトはこのリファクタをパターン化したもの

class Account
  def gamma(input_val, quantity, year_to_date)
    inportant_value1 = (input_val * quantity) + delta
    inportant_value2 = (input_val * year_to_date) + 100
    if(year_to_date - important_valuel) > 100
      important_value2 -= 20
    end
    important_value3 = important_value2 * 7
    important_value3 - 2 * important_value1
  end
end


# 新しいクラスを作り、メソッド名を元に名前をつける
# 新しいクラスに元のメソッドに含んでいいたオブジェクト(ソースオブジェクト)のための属性とメソッド内の一時変数と引数のための属性を作る
# 新しいクラスに、ソースオブジェクトと各引数をとるコンストラクタを作る
# 新しいクラスに、computeという名前のメソッドを作る
# 元のメソッドの本体をcomputeにコピーする。元のオブジェクトのメソッドを呼びダイしたいときはインスタンス変数にしてあるソースオブジェクトを使う
# =>

class Account
  def gamma(input_val, quantity, year_to_date)
    Gamma.new(self, input_val, quantity, year_to_date).compute
  end
end

class Gamma
  attr_reader :account,
    :input_val,
    :quantity,
    :year_to_date,
    :important_value1,
    :important_value2,
    :important_value3

  def initialize(account, input_val_arg, quantity_arg, year_to_date_arg)
    @account = account
    @input_val_arg = input_val_arg
    @quantity_arg = quantity_arg
    @year_to_date_arg = year_to_date_arg
  end

  def compute
    @inportant_value1 = (input_val * quantity) + @account.delta
    @inportant_value2 = (input_val * year_to_date) + 100
    important_thing
    @important_value3 = @important_value2 * 7
    @important_value3 - 2 * @important_value1
  end

  # メソッド抽出も簡単にかけられるようになる
  def important_thing
    if(year_to_date - important_valuel) > 100
      @important_value2 -= 20
    end
  end
end
