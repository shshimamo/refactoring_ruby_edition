# person = Person.new
# person.empty_name? # => true
class Person
  attr_accessor :name, :age

  def method_missing(sym, *args, &block)
    empty?(sym.to_s.sub(/^empty_/, "").chomp("?"))
  end

  def empty?(sym)
    self.send(sym).nil?
  end
end


# =>

class Person
  def self.attrs_with_empty_predicate(*args)
    attr_accessor *args
    args.each do |attribute|
      define_method "empty_#{attribute}?" do
        self.send(attribute).nil?
      end
    end
  end

  attrs_with_empty_predicate :name, :age
end
