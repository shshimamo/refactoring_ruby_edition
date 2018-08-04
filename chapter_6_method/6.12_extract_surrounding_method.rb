# サンドイッチメソッドの抽出

def charge(amount, credit_card_number)
  begin
    connection = CreditCardServer.connect(...)
    connection.send(amount, credit_card_number)
  rescue IOError => e
    Logger.log ""
    return nil
  ensure
    connection.close
  end
end

# ほぼ同じコードで中頃に違いがある場合、重複部分を抜き出しブロック付きのメソッドにする
# =>

def charge(amount, credit_card_number)
  # 違いの部分をブロックを渡す
  connect do |connection|
    connection.send(amount, credit_card_number)
  end
end

def connect
  begin
    connection = CreditCardServer.connect(...)
    yield connection # connectionを渡す
  rescue IOError => e
    Logger.log ""
    return nil
  ensure
    connection.close
  end
end
