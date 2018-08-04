class Person
end

class Female < Person
  def female?
    true
  end

  def code
    'F'
  end
end

class Male < Person
  def female?
    false
  end

  def code
    'M'
  end
end

# サブクラスからフィールドへ
# =>

class Person
  def self.create_female
    Person.new(true, 'F')
  end

  def self.create_male
    Person.new(false, 'M')
  end

  def initialize(female, code)
    @female = female
    @code = code
  end

  def female?
    @female
  end
end

