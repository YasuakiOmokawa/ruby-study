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
my_class = MyClass

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

bargain_price = Monetize.from_numeric(99, "USD")
I18n.enforce_available_locales = false
bargain_price.format # => "$99.00"

class Object
  def object_extend
    p 'hoge'
  end
end
12345.object_extend #hoge

module MyModule
  MyConstant = '外側の定数'

  class MyClass
    MyConstant = '内側の定数'
  end
end
p MyModule::MyConstant #sotogawa
p MyModule::MyClass::MyConstant #uchigawa

p MyModule.constants #[:myconstant, :myclass]
p Module.constants.include? :Object #true
p Module.constants.include? :Module #true

module M
  class C
    module M2
      Module.nesting #[M::C::M2, M::C, M] モジュールのパスが順繰りに出力される
    end
  end
end

class C
  def hoge
    'fuga'
  end
end
c = C.new # object of C. contain instance variables and link to C
C # object(instance of "Class" class). contain instance methods in itself and link to superclass
# Classのインスタンスが生成されるタイミングはいつ？ class Cしたタイミング？
# オブジェクトとは、インスタンス変数の集まりにクラスへのリンクがついたもの
p C.methods & Class.instance_methods(false) # [:allocate, :superclass, :new, :json_creatable?]
p C.instance_methods(false) # [:hoge]
C = 'hoge'

class C
  def hoge
    'fuga'
  end
end
id1 = C.object_id
C = 'hoge' #Cクラスへの参照が外れる
p id1 == C.object_id #false


p Object.class #Class
p Module.superclass #Object
p Class.class #Class

# method search
class MyClass
  def my_method; 'my_method()'; end
end
class MySubClass < MyClass; end
obj = MySubClass.new
p obj.my_method #my_method()
p MySubClass.ancestors #[:MySubClass, :MyClass, :Object, :Kernel, :BasicObject]

module M1
  def my_method
    'M1#my_method()'
  end
end
class C
  include M1
end
class D < C; end
p D.ancestors # => [D, C, M1, Object, Kernel, BasicObject]

class C2
  prepend M1
end
class D2 < C2; end
p D2.ancestors # => [D2, M1, C2, Object, Kernel, BasicObject]

module M1; end
module M2
  include M1
end
module M3
  prepend M1
  include M2
end
p M3.ancestors # => [M1, M3, M2] モジュールは初回の読み込みのみ有効化する。M2のinclude M1は2回目の読み込みなので無視される

# Kernelメソッドを定義するとどこからでも呼べる。KernelはObjectにインクルードされているため
module Kernel
  private

  def printstar
    'hoge'
  end
end
p Kernel.private_instance_methods.grep /^pr/ #[:proc, :print, :printf, :printstar]

local_time = {:city => "Rome", :now => Time.now }
ap local_time, :indent => 2

class MyClass
  def testing_self
    @var = 10     # selfのインスタンス変数
    my_method     # self.my_methodと同じ
    self
  end

  def my_method
    @var = @var + 1
  end
end
obj = MyClass.new
p obj.testing_self  # => #<MyClass:0x007f93ab08a728 @var=11>

class MyClass
  def self.tools
    'tools'
  end
end
p MyClass.tools #tools

