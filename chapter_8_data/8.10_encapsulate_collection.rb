class Course
  def initialize(name, advanced)
    @name = name
    @advanced = advanced
  end
end

class Person
  attr_accessor :courses
end

kent = Person.new
courses = []
courses << Course.new("Smalltalk Programming", false)
courses << Course.new("Appreciating Single Malts", true)
kent.courses = courses

# =>
class Person
  # 初期化もしておく
  def initialize
    @courses = []
  end

# まず適切な操作メソッドを追加
  def add_course(course)
    @courses << course
  end

  def remove_course(course)
    @courses.delete(course)
  end

  # add_courseを通すようにする
  def initialize_courses(courses)
    raise "Courses should be empty" unless @courses.empty?
    courses.each {|course| add_course(course)}
  end

  # カプセル化
  def courses
    @courses.dup
  end
end

kent = Person.new
kent.add_course << Course.new("Smalltalk Programming", false)
kent.add_course << Course.new("Appreciating Single Malts", true)


