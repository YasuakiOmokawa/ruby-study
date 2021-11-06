class Greeting
  def initialize(text)
    @text = text
  end

  def welcome
    @text
  end
end

greeting = Greeting.new('Hello')
greeting.class.instance_methods(false)
greeting.instance_variables

# ボブのorm
class Database
  def self.sql(query)
    puts query
  end
end

class Entity
  attr_reader :table, :ident

  def initialize(table, ident)
    @table = table
    @ident = ident
    Database.sql "INSERT INTO #{@table} (id) VALUES (#{@ident})"
  end

  def set(col, val)
    Database.sql "UPDATE #{@table} SET #{col}='#{val}' WHERE id=#{@ident}"
  end

  def get(col)
    Database.sql("SELECT #{col} FROM #{@table} WHERE id=#{@ident}")[0][0]
  end
end

class Movie < Entity
  def initialize(ident)
    super "movies", ident
  end

  def title
    get "title"
  end

  def title=(value)
    set "title", value
  end

  def director
    get "director"
  end

  def director=(value)
    set "director", value
  end
end

movie = Movie.new(1)
movie.title = '博士の異常な愛情'
movie.director = 'キューブリック'

3.times do
  class C
    puts 'Hello'
  end
end

class D
  def x; 'x'; end
end
class D
  def y; 'y'; end
end
d = D.new
d.x #x
d.y #y

class MyClass
  def my_method
    @v = 1
  end
end

obj = MyClass.new
obj.class           # => MyClass
# クラス定義しているので混乱しがちだけど、クラスは実際にはオブジェクトなんだそうな。
# だから、クラス.class という文法が成り立つ。
# オブジェクトなので、クラスにもclassがある。それがClassのこと。
p MyClass.class #Class
p MyClass.superclass #Object

obj.my_method
obj.instance_variables
obj.methods.grep /^my/

p String.instance_methods == 'abc'.methods #true
p String.methods == 'abc'.methods #false

'hello'.class.class
Class.instance_methods(false)

p Array.superclass
p Object.superclass
p BasicObject.superclass

p Class.superclass
