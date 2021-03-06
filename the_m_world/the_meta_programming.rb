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

class C
  def public_method
    self.private_method
  end

  private

  def private_method
    'hoge'
  end
end
p C.new.public_method #ruby2.7より、self付きなら呼べるようになった
p C.new.private_method #error

module StringExtensions
  refine String do
    def to_alphanumeric
      gsub(/[^\w\s]/, '')
    end
  end
end
"a".to_alphanumeric #error
using StringExtensions
"a".to_alphanumeric #not error

class MyClass
  def my_method
    "original my_method"
  end

  def another_method
    my_method
  end
end
module MyClassRefinements
  refine MyClass do
    def my_method
      "refined my_method"
    end
  end
end
MyClass.new.my_method #org
using MyClassRefinements
MyClass.new.my_method #ref
MyClass.new.another_method #refじゃなくてorgのほうがよばれる！wow

module Printable
  def print
    p 'printable print'
  end

  def prepare_cover
    # ...
  end
end
module Document
  def print_to_screen
    prepare_cover
    format_for_screen
    print
  end

  def format_for_screen
  end

  def print
    p 'document print'
  end
end
class Book
  include Printable
  include Document
end
Book.new.print_to_screen #document print

class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def mouse
    info = @data_source.get_mouse_info(@id)
    price = @data_source.get_mouse_price(@id)
    result = "Mouse: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end

  def cpu
    info = @data_source.get_cpu_info(@id)
    price = @data_source.get_cpu_price(@id)
    result = "Cpu: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end

  def keyboard
    info = @data_source.get_keyboard_info(@id)
    price = @data_source.get_keyboard_price(@id)
    result = "Keyboard: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end

  # ...
end

class MyClass
  define_method :my_method do |my_arg|
    my_arg * 3
  end
end
obj = MyClass.new
obj.my_method(2) #6

class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def mouse
    component :mouse
  end

  def cpu
    component :cpu
  end

  def keyboard
    component :keyboard
  end

  def component(name)
    info = @data_source.send "get_#{name}_info", @id
    price = @data_source.send "get_#{name}_price", @id
    result = "#{name.capitalize}: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end
end

exec $0
class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def self.define_component(name)
    define_method(name) do
      info = @data_source.send("get_#{name}_info", @id)
      price = @data_source.send("get_#{name}_price", @id)
      result = "{name.capitalize}: #{info} ($#{price})"
      return "* #{result}" if price >= 100
      result
    end
  end

  [:mouse, :cpu, :keyboard].each do |name|
    define_component name
  end
end
p Computer.instance_methods(false)

exec $0
class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
    data_source.methods.grep(/^get_(.*)_info$/) {
      Computer.define_component($1)
    }
  end

  def self.define_component(name)
    define_method(name) do
      info = @data_source.send("get_#{name}_info", @id)
      price = @data_source.send("get_#{name}_price", @id)
      result = "{name.capitalize}: #{info} ($#{price})"
      return "* #{result}" if price >= 100
      result
    end
  end
end
class DS
  def get_cpu_info ;end
  def get_mouse_info; end
  def get_keyboard_info; end
end
c = Computer.new(1, DS.new)
ls c
c.send(:method_missing, :my_method)

# 動的プロキシ
class DS
  def get_cpu_info(id)
    'CPU hoge'
  end
  def get_cpu_price(id)
    100
  end

  def get_mouse_info(id)
    99
  end

  def get_keyboard_info(id)
    101
  end
end
class Computer < BasicObject
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def method_missing(name)
    super if !@data_source.respond_to?("get_#{name}_info")
    info = @data_source.send("get_#{name}_info", @id)
    price = @data_source.send("get_#{name}_price", @id)
    result = "#{name.capitalize}: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end
end
c = Computer.new(1, DS.new)
p c.cpu
p c.hoge
p c.respond_to?(:mouse) #true
p c.respond_to?(:fuga) #false

class Roulette
  def method_missing(name, *args)
    person = name.to_s.capitalize
    super unless %w[Bob Frank Bill].include? person
    number = 0
    3.times do
      number = rand(10) + 1
      puts "#{number}..."
    end
    "#{person} got a #{number}"
  end
end
# Rouletteは以下のように使う。
number_of = Roulette.new
puts number_of.bob
puts number_of.frank

im = BasicObject.instance_methods
p im

def a_block
  return yield if block_given?
  'block is missing'
end
p a_block #block is missing
p a_block {'hoge'} #hoge

# ブロックを呼び出すと、呼び出し元の変数の紐付け情報が渡される
def my_method
  x = 'Goodbye'
  yield('omokawa')
end
x = 'Hello'
my_method {|y| "#{x} #{y} world."} #Hello omokawa world.

def just_yield
  yield
end
top_level_variable = 1
just_yield do
  top_level_variable += 1
  local_to_block = 1 # new binding
end
p top_level_variable #2
p local_to_block #error

v1 = 1
class MyClass
  v2 = 2
  p local_variables #[:v2]
  def my_method
    v3 = 3
    p local_variables
  end
  p local_variables #[:2]
end
o = MyClass.new
p o.my_method #[:v3]
p o.my_method #[:v3]
local_variables #[:v1, :o]

class MyClass
  def initialize
    @v = 1
  end
end
obj = MyClass.new
obj.instance_eval do
  p self
  p @v
end
v = 2
obj.instance_eval {@v = v}
p obj.instance_eval {@v} #インスタンス変数のスコープが見える

dec = lambda { |x| x - 1 }
m = ->(x) { x + 1 }
l = Proc.new { |x| x + 1 }
[dec, m, l].each do |block|
  p block.class #Proc
end
p dec.call(2) #1
p l.call(2) #3
p m.call(3) #4

def math(a, b)
  yield(a, b)
end
def do_math(a, b, &operation)
  math(a, b, &operation)
end
p do_math(2, 3) {|x, y| x * y}  # => 6
p do_math(2, 3) {|x, y| x + y}  # => 5
p do_math(2, 3) {|x, y| x - y}  # => -1

def my_method(&the_proc)
  the_proc
end
pr = my_method {|name| "Hello, #{name}!" }
p pr.class         # => Proc
p pr.call("Bill")  # => "Hello, Bill!"
def m_method(block)
  block
end
b = m_method {|name| "Hello, #{name}!" }
p b.class         # => NilClass
p b.call("Bill")  # => undef call method
def mr_method
  yield
end
bl = mr_method {|name| "Hello, #{name}!" }
p bl.class         # => String
def ms_method(a)
  yield(a)
end
a = ms_method('hoge') {|name| "Hello, #{name}!" }
p a.class         # => String

def my_method(greeting)
  "#{greeting}, #{yield}"
end
my_proc = proc {'Bill'}
p my_method('Hello', &my_proc) #Hello, Bill
p my_method('Hello', my_proc) #wrong number of argument

def double(callable_object)
  callable_object.call * 2
end
l = lambda { return 10 }
p = proc { return 10 }
[l, p].each do |obj|
  p "#{obj} -> #{obj.lambda?}"
end
p double(l) # => 20
def another_double
  p = Proc.new {return 10}
  res = p.call
  res += 10 # not exec this code
end
p another_double #10

p = Proc.new {|a,b| [a,b]}
p p.call(1) #[1,nil]
p p.call #[nil,nil]
p p.call(1,2,3) #[1,2]
l = ->(a,b) { [a,b] }
p l.call(1) #argument error
p l.call(1,2) #[1,2]
p l.call(1,2,3) #arg error

class MyClass
  def initialize(x)
    @x = x
  end

  def my_method
    @x
  end
end
obj = MyClass.new(1)
p obj.my_method #1
m2 = obj.method :my_method
p m2.call #1

module MyModule
  def my_method
    42
  end
end
unbound = MyModule.instance_method(:my_method)
p unbound.class #UnboundMethod
String.send :define_method, :another_method, unbound
p 'abc'.another_method #42

