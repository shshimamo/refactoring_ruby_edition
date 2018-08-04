class Employee
  def emails
    @emails ||= []
  end
end

# 属性の初期化を先行実行にしようと思うのはコードを読みやすくしたいときである。
# どちらがよいか好みが別れる。頑なになるほどの問題ではない。
#=>

class Employee
  def initialize
    @emails = []
  end
end
