class Employee
  def initialize
    @emails = []
  end
end

# 属性初期化の遅延実行
# コンストラクタでの初期化ロジックが多くコードを読みやすくしたいとき。
#=>

class Employee
  def initialize
  end

  def emails
    @emails ||= []
  end
end


