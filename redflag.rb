lambda {
  events = []
  setups = []

  Kernel.send :define_method, :setup do |&block|
    setups << block
  end

  Kernel.send :define_method, :event do |description, &block|
    events << {
      description: description,
      condition: block
    }
  end

  Kernel.send :define_method, :each_setup do |&block|
    setups.each do |setup|
      block.call setup
    end
  end

  Kernel.send :define_method, :each_event do |&block|
    events.each do |event|
      block.call event
    end
  end
}.call
load 'events.rb'

each_event do |event|
  env = Object.new
  each_setup do |setup|
    env.instance_eval &setup
  end
  puts "ALERT: #{event[:description]}" if env.instance_eval &(event[:condition])
end

class MyClass
  puts 'Hello'
end
result = class MyClass
  self
end
result

class C
  def m1
    def m2;end
  end
end
class D < C;end
obj = D.new
p C.instance_methods(false) #[:m1]
obj.m1
p C.instance_methods(false) #[:m1, :m2]

def add_method_to(a_class)
  a_class.class_eval do
    def m; 'Hello!';end
  end
end
add_method_to String
'abc'.m #Hello!
class C1
  def x
    1
  end
end
c1 = C1.new
c1.hoge #nomethod error
c1.instance_eval do
  def hoge; x; end
end
p c1.hoge #1

class MyClass
  @my_var = 1
  def self.read; @my_var; end
  def write; @my_var = 2; end
  def read; @my_var; end
end
obj = MyClass.new
p obj.read            # => nil
obj.write
p obj.read            # => 2
p MyClass.read        # => 1

loan = Loan.new('book1')
p loan.to_s

# classキーワードを使わずにクラスを書くには？
class MyClass < Array
  def my_method
    'Hello!'
  end
end
MyClass2 = Class.new(Array) do
  def my_method
    'Hello!'
  end
end
m = MyClass.new
m2 = MyClass2.new
p m.append(m.my_method).eql? m2.append(m2.my_method) #true

str = 'hoge'
def str.title?
  self.upcase == self
end
p str.title? #false
p str.methods.grep(/title?/) #[:title?]
p str.singleton_methods #[:title?]

class Book
  def title;end # ...

  def subtitle;end # ...

  def lend_to(user)
    puts "Lending to #{user}"
    # ...
  end

  def self.deprecate(old_method, new_method)
    define_method(old_method) do |*args, &block|
      warn "Warning: #{old_method}() is deprecated. Use #{new_method}()."
      send(new_method, *args, &block)
    end
  end

  deprecate :GetTitle, :title
  deprecate :LEND_TO_USER, :lend_to
  deprecate :title2, :subtitle
end
b = Book.new
p b.LEND_TO_USER('bill')

'abc'.singleton_class
str = 'abc'
def str.my_singleton_method; end
str.singleton_class.instance_methods.grep(/my/) #[:my_singleton_method]

class C
  def a_method
    'C#a_method'
  end
  class << self
    def a_class_method
      'C.a_class_method()'
    end
  end
end
class D < C;end
obj = D.new
p obj.a_method #C#a_method
class << obj
  def a_singleton_method
    'obj#a_singleton_method()'
  end
end
p obj.singleton_class.superclass #D
p C.singleton_class ##C
p D.singleton_class ##D
p D.singleton_class.superclass ##C
p C.singleton_class.superclass ##Object
p D.a_class_method #C.a_class_method()
class MyClass
  def self.another_method;end
end
def MyClass.a_method;end
class MyClass
  class << self #特異クラスをオープンしている
    def yet_method;end
  end
end

s1,s2 = 'abc','def'
s1.instance_eval do
  def swooish!; reverse ;end
end
p s1.swooish! #cba
p s2.respond_to?(:swooish!) #false

class MC
  attr_accessor :a
end
obj = MC.new
obj.a = 2
obj.a #2

class MC2
  class << self
    attr_accessor :c
  end
end
MC2.c = 'It works!'
p MC2.c #It works!

module MyModule
  def a_method;'hello';end
end
class MyClass3
  class << self
    include MyModule
  end
end
p MyClass3.a_method #Hello
obj = Object.new
obj.extend MyModule
p obj.a_method #hello
class MyClass4
  extend MyModule
end
p MyClass4.a_method #hello

class String
  alias_method :real_length, :length

  def length
    real_length > 5 ? 'long' : 'short'
  end
end
p 'war and piece'.length # long
p 'war and piece'.real_length #13

module StringRefinements
  refine String do
    def length
      super > 5 ? 'long' : 'short'
    end
  end
end
using StringRefinements
p 'war and piece'.length #long

module ExplicitString
  def length
    super > 5 ? 'long' : 'short'
  end
end
String.class_eval do
  prepend ExplicitString
end
p "War and Peace".length      # => long

module PrependFixnum
  def +(value)
    self + 1
  end
end
Fixnum.class_eval do
  prepend PrependFixnum
end
1 + 2 #2

class Fixnum
  alias_method :old_plus, :+

  def +(value)
    self.old_plus(value) + old_plus(1)
  end
end
1 + 1 #3
