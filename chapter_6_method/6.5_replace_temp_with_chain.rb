# 1時変数を使って式の結果を保存している
# メソッドチェーンに変更する

mock = Mock.new
expectation = mock.expects(:1_method_name)
expectation.with('arguments')
expectation.returns([1, :array])

# =>

mock = Mock.new
mock.expects(:1_method_name).with('arguments').returns([1, :array])

