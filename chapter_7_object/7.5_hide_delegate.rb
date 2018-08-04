# デメテルと同じ

class Person
  attr_accessor :department
end

class Department
  attr_reader :manager
  def initialize(manager)
    @manager = manager
  end
end


manager = John.department.managaer


# => 

class Person
  attr_accessor :department

  def manager
    @department.manager
  end
end

# delegateの場合
class Person
  extend Forwardable
  attr_accessor :department

  def_delegator :@department, :manager
end


