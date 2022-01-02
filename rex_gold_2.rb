class C
  CONST = "Good, night"
end

module M
  CONST = "Good, evening"
end

module M
  class C
    CONST = "Hello, world"
  end
end

module M
  class C
    p CONST
  end
end


class C
end

module M
  CONST = "Hello, world"

  C.class_eval do
    def awesome_method
      CONST
    end
  end
end

p C.new.awesome_method


module M
  def class_m
    "class_m"
  end
end

class C
  include M
end
p C.methods.include? :class_m


class S
  @@val = 0
  def initialize
    @@val += 1
  end
end

class C < S
  class << C
    @@val += 1
  end

  def initialize
  end
end

C.new
C.new
S.new
S.new

p C.class_variable_get(:@@val)


class C
  def m1
    200
  end
end

module R
  refine C do
    def m1
      100
    end
  end
end

using R

c = C.new
puts c.m1


class C
  def self.m2
    200
  end
end

module R
  refine C.singleton_class do
    def m1
      100
    end
  end
end

using R

puts C.m1
puts C.m2


module M1
  class C1
    CONST = "001"
  end

  class C2 < C1
    # CONST = "010"
    p CONST

    module M2
      # CONST = "011"

      class Ca
        # CONST = "100"
      end

      class Cb < Ca
        # p const_get(:CONST)
        # p CONST
      end
    end
  end
end


val = 1 + 1/2r
puts val.class
val2 = 1 + 1
puts val2.class
val3 = 1 - 1.0
puts val3.class


def hoge(*args, &block)
  block.call(args)
end

hoge(1,2,3,4) do |args|
  p args.length < 0 ? "hello" : args
end


def m1(*)
  str = yield if block_given?
  p "m1 #{str}"
end

def m2(*args)
  str = yield(args) if block_given?
  p "m2 #{str}"
end

m1 m2 {
  "hello"
}

m2 {|args| "hello #{args}"}
m2(1,2,3,4) {|*args| "hello #{args}"}


module M
  def method_missing(id, *args)
    puts "M#method_missing"
  end
  # class << self
  #   def method_missing(id, *args)
  #     puts "M.method_missing"
  #   end
  # end
end
class A
  # include M
  def method_missing(id, *args)
    puts "A#method_missing"
  end
  class << self
    include M
    # def method_missing(id, *args)
    #   puts "A.method_missing"
    #   super
    # end
  end
end
class B < A
  class << self
    def method_missing(id, *args)
      puts "B.method_missing"
      super
    end
  end
end

B.new.dummy_method
A.new.dummy
M.dummy
B.dummy_method
A.dummy


class C
  def initialize
  end
end

p C.new.public_methods.include? :initialize #false
p C.new.private_methods.include? :initialize #true


class Human
  NAME = "Unknown"

  def self.name
    const_get(:NAME)
  end
  def name
    methods
  end
end

class Fukuzawa < Human
  NAME = "Yukichi"
end
class Natsume < Fukuzawa
  # NAME = "Yukichi"
end

puts Fukuzawa.name #Y
puts Human.new.name #U
puts Human.name #U
puts Natsume.name #Y
puts Human.const_get(:NAME)


class C
end

module M
  refine C do
    def m1
      100
    end
  end
end

class C
  def m1
    400
  end

  def self.using_m
    using M
  end
end

C.using_m

puts C.new.m1


module M
  def refer_const
    CONST
  end
end

module E
  CONST = '010'
end

class D
  CONST = "001"
end

class C < D
  include E
  include M
  CONST = '100'
end

c = C.new
p c.refer_const


a = (1..5).partition(&:odd?)
p a


class S
  @@val = 0
  def initialize
    @@val += 1
  end
end

class C < S
  class << C
    @@val += 2
  end

  def initialize
    @@val += 1
    super
  end
end

C.new
C.new
S.new
S.new

p C.class_variable_get(:@@val)


def foo(arg3: 1, arg1: 10, **_)
  p arg1
  p arg3
end
option = {arg2: 900}
foo **option


enum_char = Enumerator.new do |y|
  "apple".each_char do |chr|
    y << chr
  end
end

array = enum_char.map do |chr|
  chr.ord
end

p array


class S
  @@val = 0
  def initialize
    @@val += 1
  end
end

class C < S
  class << C
    @@val += 1
  end
end

C.new
C.new
S.new
S.new

p C.class_variable_get(:@@val)

require 'date'
d = Date.today - Date.new(2015,10,1)
p d.class

p "Matz is my tEacher"[/[a-z][A-Z].*/]


t = Time.new(2021,12,19,zone = 'JST')
r = Rational(1, 24)
(t-r).class


def hoge(*args, &block)
  block.call(args)
  block.yield(args)
  block.(args)
  block[args]
end
hoge(1,2,3,4) do |*args|
  p args.length < 0 ? "hello" : args
end

x = 'my x var'
MyClass = Class.new do
  puts "x in class -> #{x}"
  define_method :my_method do
     puts "x in method -> #{x}"
  end
end
puts MyClass.new.my_method


def define_methods
  shared = 0

  Kernel.send :define_method, :counter do
    shared
  end

  Kernel.send :define_method, :inc do |x|
    shared += x
  end

  Kernel.send :define_method, :sub do |x|
    shared -= x
  end
end

define_methods

counter       # => 0
inc(4)
counter       # => 4
sub(4)
counter #0


class MC
  def initialize
    @v = 1
  end
end
obj = MC.new
obj.instance_eval { @v = 2 }
p obj.instance_eval { @v }


class MC
  def initialize
    @v = 1
  end
end
class D
  def twisted_method
    @y = 2
    MC.new.instance_exec(@y) { |y| "v: #{@v}, y: #{y}" }
    # MC.new.instance_eval { "v: #{@v}, y: #{@y}" }
  end
end
D.new.twisted_method


inc = Proc.new { |x| x + 1 }
inc.call 1
inc.yield 1
inc.(1)
inc[1]
dec = lambda { |x| x - 1 }
p dec.class
dec.call 1
inc.call 1, 2
dec.call 1, 2
inc = Proc.new { |x| x + 1; break }
def break_test_lambda
  dec = lambda { |x| x - 1; break }
  dec.call(1)
  p 'break out of lambda'
end
break_test_lambda
def break_test_proc
  dec = Proc.new { |x| x - 1; break }
  dec.call(1, 2)
  p 'break out of proc'
end
break_test_proc


def proc_return
  f = Proc.new { |n| break n * 10 }
  ret = [1, 2, 3].map(&f)
  "ret: #{ret}"
end

def lambda_return
  f = -> (n) { break n * 10 }
  ret = [1, 2, 3].map(&f)
  "ret: #{ret}"
end

def block_return
  ret = [1, 2, 3].map { |n| break n * 10 }
  "ret: #{ret}"
end

proc_return   #=> 10
lambda_return #=> "ret: [10, 20, 30]"
block_return  #=> 10


def proc_next
  f = Proc.new { |n| next n * 10 }
  ret = [1, 2, 3].map(&f)
  "ret: #{ret}"
end

def lambda_next
  f = -> (n) { next n * 10 }
  ret = [1, 2, 3].map(&f)
  "ret: #{ret}"
end

def block_next
  ret = [1, 2, 3].map { |n| next n * 10 }
  "ret: #{ret}"
end

proc_next   #=> "ret: [10, 20, 30]"
lambda_next #=> "ret: [10, 20, 30]"
block_next  #=> "ret: [10, 20, 30]"


def proc_return
  Proc.new { |n| return n * 10 }
end

def lambda_return
  -> (n) { return n * 10 }
end

[1, 2, 3].map(&proc_return)   #=> LocalJumpError: unexpected return
[1, 2, 3].map(&lambda_return) #=> [10, 20, 30]


enum = "apple".enum_for(:)

p enum.next
p enum.next
p enum.next
p enum.next
p enum.next


module Enumerable
  def repeat(n)
    raise ArgumentError, "#{n} is negative!" if n < 0
    unless block_given?
      # __method__ はここでは :repeat
      return to_enum(__method__, n) do
        # size メソッドが nil でなければ size * n を返す。
        p "size -> #{size}"
        sz = size
        sz * n if sz
      end
    end
    each do |*val|
      p "val -> #{val}"
      n.times { yield *val }
    end
  end
end

%i[hello world].repeat(2) { |w| puts w }
# => 'hello', 'hello', 'world', 'world'
enum = (1..14).repeat(3)
# => #<Enumerator: 1..14:repeat(3)>
enum.first(4) # => [1, 1, 1, 2]
enum.size # => 42
enum = (0..1).repeat(3)


begin
  print "liberty" + :fish.to_s
rescue TypeError
  print "TypeError."
rescue
  print "Error."
else
  print "Else."
ensure
  print "Ensure."
end


def foo(n)
  n ** n
end
foo = Proc.new { |n|
  n * 3
}
foo = 'hoge'
puts foo[2] * 2 #12
puts foo.(2) * 4 #24
puts foo.call(2) * 5 #30
puts foo.yield(2) * 6 #36
p foo


10.times{|d| print d < 2...d > 5 ? "O" : "X" }
10.times{|d| p d < 2...d > 5 ? "O" : "X"}
1 < 2...1 > 5


def foo(arg1:100, arg2:200)
  puts arg1
  puts arg2
end

option = {arg2: 900}

foo arg1: 200, *option


module M
  @@val = 75

  class Parent
    @@val = 100
  end

  class Child < Parent
    @@val += 50
    def equality_class
      if Child < Parent
        @@val += 25
      else
        @@val += 30
      end
    end
  end

  class Aunt
    @@val = 100
    Child.new
  end
end
p M::Child.class_variable_get(:@@val)
M::Child.new.equality_class
p M::Child.class_variable_get(:@@val)
p M.class_variable_get(:@@val)
p M::Parent.class_variable_get(:@@val)
p M::Aunt.class_variable_get(:@@val)


val = 1i * 1i
puts val.class


module SuperMod
  module BaseMod
    p Module.nesting
  end
end


array = ["a", "b", "c"].freeze
array = array.map!{|content| content.succ}

p array


class C
end

module M
  refine C do
    def m1(value)
      super value - 100
    end
  end
end

class C
  def m1(value)
    value - 100
  end
end

# using M

class K < C
  def m1(value)
    super value - 100
  end

  def self.usings
    using M
  end
end

puts K.new.m1 400
puts K.usings


module K
  class P
    CONST = "Good, night"
  end
end

module K::P::M
  class C
    CONST = "Good, evening"
  end
end

module M
  class C
    CONST = "Hello, world"
  end
end

class K::P
    p CONST
    class M::C
    # p CONST
  end
end


m = Module.new

CONST2 = "Constant in Toplevel"

_proc = Proc.new do
  CONST2 = "Constant in Proc"
end

m.instance_eval(<<-EOS)
  CONST = "Constant in Module instance"

  def const
    CONST
  end
EOS

m.module_eval(&_proc)

p m.const


p Class.method_defined? :new
p String.method_defined? :new
p Class.singleton_class.method_defined? :new
p String.singleton_class.method_defined? :new

class Object
  CONST = "1"
  def const_succ
    CONST.succ!
  end
end

class Child1
  const_succ
  class << self
    const_succ
  end
end

class Child2
  const_succ
  def initialize
    const_succ
  end
end

Child1.new
Child2.new

p Object::CONST


class Hoge
  def hoge
    'hoge'
  end
end


module MathConstant
  PI = 3.14
end

class Area
  include MathConstant

  def circle(r)
    r * r * PI
  end
end

area = Area.new
p area.circle 10


module MathConstant
  PI = 3.14
end

class Area < MathConstant
  def circle(r)
    r * r * PI
  end
end

area = Area.new
p area.circle 10


module MathConstant
  PI = 3.14
end

class Area
  def circle(r)
    r * r * MathConstant::PI
  end
end

area = Area.new
p area.circle 10


module MathConstant
  PI = 3.14
end

class Area
  def circle(r)
    r * r * ::PI
  end
end

area = Area.new
p area.circle 10

class Foo
  def initialize(num)
    @hoge = num
  end
end

num = (1..99).to_a.shuffle.first
foo = Foo.new(num)


class Foo
  attr_reader :var

  @var = "1"

  def initialize
    @var = "2"
  end
end

class Baz < Foo
  def self.var
    @var
  end
end

def Foo.var
  @var
end

arr = [
  Foo.new.var,
  Foo.var,
  Baz.new.var,
  Baz.var
]

p arr


class Array
  def succ_each(step = 1)
    return each(:succ_each) unless block_given?

    each do |int|
      yield int + step
    end
  end
end

p [98, 99, 100].succ_each(2).map {|succ_chr| succ_chr.chr}

[101, 102, 103].succ_each(5) do |succ_chr|
  p succ_chr.chr
end


class Array
  def succ_each(step = 1)
    return to_enum(:succ_each) unless block_given?

    each do |int|
      yield int + step
    end
  end
end

p [98, 99, 100].succ_each(2).map {|succ_chr| succ_chr.chr}

[101, 102, 103].succ_each(5) do |succ_chr|
  p succ_chr.chr
end


class Array
  def succ_each(step = 1)
    unless block_given?
      Enumerator.new do |yielder|
        each do |int|
          yielder << int + step
        end
      end
    else
      each do |int|
        yield int + step
      end
    end
  end
end

p [98, 99, 100].succ_each(2).map {|succ_chr| succ_chr.chr}

[101, 102, 103].succ_each(5) do |succ_chr|
  p succ_chr.chr
end


module Parent
  def method_1
    __method__
  end
end

module Child
  include Parent
  extend self
end

p Child::method_1


class C
  def self.m1
    'C.m1'
  end
end

module M
  refine C.singleton_class do
    def m1
      'C.m1 in M'
    end
  end
end

using M

puts C.m1 # C.m1 in M と表示されます。


10.times{|d| print d < 2...d > 5 ? "O" : "X" }
0<2, 0>5 .. true
1<2, 1>5 .. false > true
2<2, 2>5 .. false > true
3<2, 3>5 .. false > true
4<2, 4>5 .. false > true
5<2, 5>5 .. false > true
6<2, 6>5 .. true > true
7<2, 7>5 .. false
8<2, 8>5 .. false
9<2, 9>5 .. false


module K
  class P
    p Module.nesting # [K::P, K]と表示されます
  end
end

module K::P::M
  class C
    CONST = 'k,p,m,c'
    p Module.nesting # [K::P::M::C, K::P::M]と表示されます
  end
end

module M
  class C
    p Module.nesting # [M::C, M]と表示されます
  end
end

class K::P
  class M::C
    p CONST
    p Module.nesting # [K::P::M::C, K::P]と表示されます
  end
end


p Class.method_defined? :new #=> ture
p String.method_defined? :new #=> false
p Class.singleton_class.method_defined? :new #=> ture
p String.singleton_class.method_defined? :new #=> ture

p Class.singleton_class.method_defined? :new, false #=> ture
p String.singleton_class.method_defined? :new, false #=> ture

p String.method_defined? :new #=> false
class String
  def new
    'new'
  end
end
p String.method_defined? :new #=> false

p String.method(:new).source_location



module Parent
  def method_1
    __method__
  end
end
module Child
  include Parent
  extend self
end
p Child::method_1

module Parent
  def method_1
    __method__
  end
end
module Child
  include Parent
end
module Child
  extend self
end
Child.ancestors
p Child::method_1

module Parent
  def method_1
    __method__
  end
end
module Child
  extend self
  include Parent
end
p Child::method_1


p (1..10).lazy.map{|num|
  num * 2
}.take(3).inject(0, &:+)


x,*y = *[0,1,2]


module M1
  def foo
  end
  def self.moo
    undef foo
  end
end
M1.instance_methods false #=> ["foo"]
M1.moo
M1.instance_methods false #=> []
module M2
  def foo
  end
  def self.moo
    undef_method :foo
  end
end
M2.instance_methods false #=> ["foo"]
M2.moo
M2.instance_methods false #=> []

module M2
  def foo
  end
  def self.moo
    undef foo
  end
end

class C
  def foo
  end
  def self.moo
    undef_method 'foo'
  end
end
C.moo


class A
  def ok
    puts 'A'
  end
end
class B < A
  def ok
    puts 'B'
  end
end

B.new.ok   # => B

# undef_method の場合はスーパークラスに同名のメソッドがあっても
# その呼び出しはエラーになる
class B
  undef_method :ok
end
B.new.ok   # => NameError

# remove_method の場合はスーパークラスに同名のメソッドがあると
# それが呼ばれる
class B
  remove_method :ok
end
B.new.ok   # => A

obj = Hash.new
obj.define_singleton_method(:hoge) do
  'hoge'
end
p Marshal.dump(obj)
p Marshal.dump(IO.new(1))


t = Thread.new do
  raise "unhandled exception"
end
sleep

Thread.new do
  (1..3).each{|i|
    p i
    Thread.pass
  }
  exit
end

loop do
  Thread.pass
  p :main
end


def top_level_method
  'hoge'
end

String.methods == "abc".methods
String.instance_methods == "abc".methods

p Class.superclass
# Objectを継承してModuleが実装されている
p Module.superclass

class C
  def public_method
    self.private_method
  end

  private
  def private_method
    'private'
  end
end
# => nil
C.new.public_method
class D < C
  def public
    private_method
  end
end
D.new.public


class MyClass
  def my_method(my_arg)
    my_arg * 2
  end

  define_method :defined do |arg|
    arg * 3
  end
end
obj = MyClass.new()
obj.send(:my_method1, 2)
obj.send(:hoge, 2)

obj.define_method(:defined) do |arg|
  arg * 3
end
p obj.defined(3)


class MyClass
  # これだとインスタンスの属性定義になってしまう
  attr_accessor :a
end

MyClass.a # => NoMethodError: undefined method `c' for MyClass:Class
mc = MyClass.new()
mc.a = 1
mc.a # => 1

class MyClass
  # 特異クラスに属性追加することでクラスに属性追加
  class << self
    # クラス属性の定義コンテキストで定義
    attr_accessor :c
  end
end

MyClass.c = '属性定義'
MyClass.c # => '属性定義'

module MyModule
  def my_method
    puts 1
  end
end

class MyClass
  class << self
    # 特異クラス内でインスタンスメソッドを拡張させるとクラスメソッドとして定義可能
    include MyModule
  end
end

MyClass.my_method # => 1


module MyModule
  def my_method
    puts 1
  end
end
module MyModule2
  include MyModule
  extend self
end
class MyClass
  include MyModule2
end
# p MyClass.my_method # => 1
p MyModule2.my_method # => 1

ENV[:PATH] = "user/..." # => キーがシンボルなので指定不可
ENV['PATH'] = 1234 # => 代入する値が文字列ではないので指定不可
ENV['PATH'] = 'user/local...' # => どちらも文字列なので指定可

class Foo
  def foo
    @value
  end
end
p Foo.new.foo # => nil

class Foo
  @@value
  def bar
    @@value # => uninitialized class variable ... (NameError)
  end
end
p Foo.new.bar


CONST = "a"
def foo1; p CONST; end
def foo2; p CONST = "b"; end # => dynamic constant assignment
def foo3; p CONST += "c"; end # => dynamic constant assignment
def foo4; p CONST << "d"; end
def foo5; p CONST + "d"; end

foo1 # => "a"
foo2 # 定義の段階でエラー
foo3 # 定義の段階でエラー
foo4 # => "ad" 破壊的なメソッドではないのでいけるらしいです
foo5

arr = [1,2,3].freeze
p arr.uniq
p arr.uniq!
p arr + [4,5]
p arr = [4,5]


class C
  attr_reader :num

  def initialize(num)
    @num = num
  end
end

class MyNum < C
  def <=>(other)
    @num <=> other.num
  end
end

var1 = C.new(3)
var2 = C.new(1)
var3 = C.new(2)
p [var1, var2, var3].sort.map{|n| n.num } # => `sort': comparison of C with C failed (ArgumentError)

num1 = MyNum.new(30)
num2 = MyNum.new(10)
num3 = MyNum.new(20)
p [num1, num2, num3].sort.map{|n| n.num } # => [10, 20, 30]

for var in [0,1,2] do
  num = var
end
p num
[1,2,3].each do |var|
  num2 = var
end
p num2

# ブロックはつくらない
i = 1
while i > 0 do
  num3 = i
  i = i - 1
end
p num3

a = 1
def aa(a)
  yield(a)
end
aa(a) {|a| a += 1 }
p a # => 1

class Foo
  @@var
  def var
    @@var
  end
end
p Foo.new.var

class Foo
  def foo
    @var
  end
end
p Foo.new.foo

loop do
  num2 = 1
  break
end
p num2

while 1 == 1 do
  num3 = 1
  break
end
p num3


# b = 'h1'
def hoge(tag)
  "<#{tag}>#{yield}</#{tag}>"
end
p hoge('h1') { 'hoge' }
p hoge('b') { 'fuga' }


def msd
  begin
    "a"
  rescue
    "b"
  else
    "c"
  ensure
    p "d"
  end
end
p msd # => "c"


class C
  def internal_use_private_and_protected
    protected_method # 呼び出し可
    private_method # 呼び出し可
  end

  def internal_use_private_and_protected_with_reciever
    self.protected_method # 呼び出し可。自クラスから呼び出し可。
    self.private_method # 呼び出し不可。レシーバーから呼び出せない。
  end

  def use_protected(other)
    other.protected_method # 自クラス、サブクラスなら呼び出し可。
  end

  def use_private(other)
    other.private_method # 自クラス、サブクラスなら呼び出し可。
  end

  protected
  def protected_method
    puts "protected_method"
  end

  private
  def private_method
    puts "private_method"
  end
end

class D < C
end

c = C.new
# 外部から直接呼び出し不可
c.protected_method #=> NoMethodError: protected method `protected_method' called for

# 外部から直接呼び出し不可
c.private_method #=> NoMethodError: private method `private_method' called for

# レシーバーなしでは両方呼び出し可
c.internal_use_private_and_protected
#=> protected_method
#=> private_method

# レシーバーあり(自クラス)ではprotectedのみ呼び出せる
c.internal_use_private_and_protected_with_reciever
#=> protected_method
#=> NoMethodError: private method `private_method' called for

c.use_protected(d)

d = D.new
# サブクラスから呼び出し可
d.use_protected(d) #=>protected_method
d.use_private(d)


class C
  protected
  def protected_method
    puts "protected_method"
  end

  private
  def private_method
    puts "private_method"
  end
end

class D < C
  #表示内容の変更と可視性をpublicへ変更
  def protected_method
    puts "edit protected_method"
  end

  #表示内容の変更と可視性をpublicへ変更
  def private_method
    puts "edit private_method"
  end
end

d = D.new
p d.protected_method # =>edit protected_method
p d.private_method # =>edit private_method


ENV['A'] = "TEST"
ENV[1] = "TEST"
ENV['A'] = 1


ENV.class


X = 'abc'
def m
  X #  (1)
  X = 'def' # (2)
  X += 'def' #(3)
  X << 'def' # (4)
end


require 'english'

class ScopeResearchClass
  def public_method
    'public'
  end

  def use_protected(other)
    puts other.protected_method
  end

  def use_private(other)
    other.private_method
  rescue
    puts $ERROR_INFO
  end

  def internal_use_private_and_protected
    puts protected_method
    puts private_method
  end

  def internal_use_private_and_protected_with_reciever
    puts self.protected_method
    self.private_method
  rescue
    puts $ERROR_INFO
  end

  protected

  def protected_method
    'protected'
  end

  private

  def private_method
    'private'
  end
end

pc1 = ScopeResearchClass.new
pc2 = ScopeResearchClass.new

begin
  pc1.protected_method
rescue
  # protected は外部からは呼び出せずにエラー
  puts $ERROR_INFO
end

begin
  pc1.private_method
rescue
  # private は外部からは呼び出せずにエラー
  puts $ERROR_INFO
end

# private / protected ともに内部から利用可能
pc1.internal_use_private_and_protected

# protected は レシーバーつきでも呼び出し可能
# private は レシーバーつきだと呼び出せず
pc1.internal_use_private_and_protected_with_reciever

class Hoge
  def can_not_use_external_protected_method(other)
    other.protected_method
  rescue
    puts $ERROR_INFO
  end
end

# 関係ないクラス内からは呼び出せないことを確認
Hoge.new.can_not_use_external_protected_method(pc2)

# protected メソッドは自クラスに別インスタンスを渡しても呼び出し可能
pc1.use_protected(pc2)

# private メソッドは自クラスに別インスタンスを渡した場合、レシーバーの指定が出来ないのでエラーになる
pc1.use_private(pc2)

class ChildProtectedClass < ScopeResearchClass
  def use_protected_from_child(other)
    puts other.protected_method
  end
end

# protected メソッドはサブクラスに別インスタンスを渡しても呼び出し可能
ChildProtectedClass.new.use_protected_from_child(pc2)



class Foo
  def _val
    @val
  end
  protected :_val

  def op(other)

    # other も Foo のインスタンスを想定
    # _val が private だと関数形式でしか呼べないため
    # このように利用できない

    self._val + other._val
  end
end

f1 = Foo.new
f1.instance_variable_set(:@val, 1) # => @val に無理やり 1 を設定
f2 = Foo.new
f2.instance_variable_set(:@val, 2) # => @val に無理やり 2 を設定
puts f1.op(f2) # => 3


a, b, c = catch :exit do
  for x in 1..10
    for y in 1..10
      throw :exit, [x, y, 1] if x + y == 10
    end
  end
end
puts a, b, c


a, b = catch :exit do
  for x in 1..10
    for y in 1..10
      return [x, y] if x + y == 10
    end
  end
end

a, b = catch :exit do
  for x in 1..10
    for y in 1..10
      break [x, y] if x + y == 10
    end
  end
end

result = catch do |tag|
  for i in 1..2
    for j in 1..2
      for k in 1..2
        next k
      end
    end
  end
end
p result #=> 1


a, b, c = catch :ext do
  for x in 1..10
    for y in 1..10
      throw :ext, [x, y, 1] if x + y == 10
    end
  end
end
puts a, b, c


def foo
  throw :exit, 25
end

ret = catch(:exit) do
  begin
    foo
    some_process()    # 絶対に実行されない
    10
  ensure
    p "ensure"
  end
end
puts ret
#=> ensure
#   25


def func(arg, *args)
  p arg
  p args
  p *args
end

func *[1, 2, 3]
func 1, 2, 3


def func(**hash)
  p hash
  p **hash
end

func key: "val"
func **{key: "val"}


# Procの場合
def proc_test
  proc = Proc.new{return "生成元のスコープ(メソッド)から脱出"}
  proc.call
  2 # ここは実行されない
end

p proc_test # => "生成元のスコープ(メソッド)から脱出"


# lambdaの場合
def lambda_test
  lambda = -> {return "呼び出し元へ復帰"}
  lambda.call
  2 # ここは実行される
end

p lambda_test # => 2


class Foo
  def initialize(data)
    @data = data
  end
  def method_missing(name, lang)
    if name.to_s =~ /\Afind_(\d+)_in\z/
      begin
        p @data[lang][$1.to_i]
      rescue => e
        p "#{lang} unknown -> #{e}"
      end
    else
      super
    end
  end
end
dic = Foo.new({:English => %w(zero one two), :Esperanto => %w(nulo unu du)})
dic.find_2_in :Esperanto #=> "du"
dic.find_0_in :Esperanto #=> "nulo"
dic.find_3_in :English
dic.find_3_in :Japan
dic.no_method


var1 = "".freeze
var1 = "foo" # 代入は防げない
p var1 #=> "foo"
var1.replace("bar") # 凍結後、再代入すると破壊的メソッドで変更可能でした
p var1 # => "bar"
var1.freeze # 再度凍結
var1.replace("bar")# can't modify frozen string (RuntimeError)


class C
end

module M
  CONST = "Hello, world"

  C.class_eval do
    def awesome_method
      CONST
    end
  end
end

p C.new.awesome_method

class C
  CONST = "Hello, world"
end

module M
  C.class_eval(<<-CODE)
    def awesome_method
      CONST
    end
  CODE
end

p C.new.awesome_method


module M
  def class_m
    "class_m"
  end
end
class C
  include M
end
p C.methods.include? :class_m
class C
  extend M
end
p C.methods.include? :class_m


f = Fiber.new do
  (1..3).each do |i|
    Fiber.yield i
  end
  nil
end

p f.resume # => 1
p f.resume # => 2
p f.resume # => 3
p f.resume # => nil
p f.resume # FiberError(例外発生)


class Sample
  def initialize
    @x = 1
  end
end

sample = Sample.new
sample.instance_eval do
  @y = 1
  def output # =>　これは特異クラスのインスタンスメソッドになる
    @x + @y
  end
end

puts sample.output # => 2
puts sample.singleton_class.instance_methods.grep(/output/) # => output


class Sample
  def initialize
    @x = 1
  end
end

Sample.class_eval do
  @y = 1 # クラスインスタンス変数
  def output # クラス内のインスタンスメソッド
    @@a = 1 # クラス変数
    @x
  end
end

sample = Sample.new
puts sample.instance_variables # => @x
puts Sample.instance_variables # => @y
puts Sample.class_variables # => @@a
puts sample.output # => 1
puts Sample.instance_methods.grep(/output/) # => output


class S
  @@val = 0
  def initialize
    @@val += 1
  end
end

class C < S
  class << C
    @@val += 1
  end

  def initialize
  end
end

C.new
C.new
S.new
S.new

p C.class_variable_get(:@@val)


class C
  def m1
    200
  end
end

module R
  refine C do
    def m1
      100
    end
  end
end

using R

c = C.new
puts c.m1

module M1
end

module M2
end

class C
  include M1
  include M2
end

p C.ancestors


p Marshal.dump({a: 1, b: 2, c: 5})

file = File.open("/tmp/marshaldata", "w+") # => #<File:/tmp/marshaldata>
Marshal.dump({a: 1, b: 2, c: 3}, file)
Marshal.dump(Hash.new {})
Marshal.dump([])

class C
end
c = C.new
Marshal.dump(c)
c.instance_eval do
  def hoge
    'hoge'
  end
end
Marshal.dump(c)
ac = Class.new
Marshal.dump(ac)
file = File.open("/tmp/marshaldata", "r+")
Marshal.dump(file)
p Marshal.load(file)


class C
  def hoge
    puts "hogeを定義"
  end
end

module M
  refine C do
    def hoge
      puts "hogeの内容を変更: 変更を有効にしました"
    end
  end
end
module M2
  refine C do
    def hoge
      puts "hogeの内容を変更: 変更を有効にしました2"
    end
  end
end

c = C.new
c.hoge

using M
using M2

c.hoge


module M
  def hoge
    'hoge'
  end
end
class C
    include M
end
p C.ancestors
p C.hoge
class C
  extend M
end
p C.ancestors
p C.hoge


module M1
end

module M2
end

class Cls1
  include M1
  def self.hoge
    p self.ancestors
  end
end
p Cls1.hoge
class Cls2 < Cls1
  def foo
    p self.ancestors
  end
  include M2
end

Cls2.new.foo
c1 = Cls1.new


module M
  def self.append_features(include_class_name)
    puts "append_features"
    super # このsuperを書かないとエラー発生
  end
  def func
    p "Hello World"
  end
end

class C
  include M
end

C.new.func


class Object
  CONST = "100"
end

class C
  CONST = "010"
  class << self
    CONST = "001"
    def const
      CONST
    end
  end
end

p C::CONST
p CONST
p C.const


def m1(*)
  str = yield if block_given?
  p "m1 #{str}"
end

def m2(*)
  str = yield if block_given?
  p "m2 #{str}"
end

m1 m2 do
  "hello"
end


module M
  def class_m
    "class_m"
  end
end

class C
  extend M
end

p C.methods.include? :class_m


class C
  def m1
    200
  end
end

module R
  refine C do
    def m1
      100
    end
  end
end

c = C.new
puts c.m1


module M
  def method_missing(id, *args)
    puts "M#method_missing"
  end
end
class A
  include M
  def method_missing(id, *args)
    puts "A#method_missing"
  end
end
class B < A
  class << self
    def method_missing(id, *args)
      puts "B.method_missing"
    end
  end
end

B.new.dummy_method #A
B.dummy_method #B
module M
  def method_missing(id, *args)
    puts "M#method_missing"
  end
end
class A
  extend M
  def method_missing(id, *args)
    puts "A#method_missing"
  end
end
A.dummy_method #M


class C
  def self.m1
    200
  end
end

module R
  refine C do
    def self.m1
      100
    end
  end
end

using R

puts C.m1


class C
  def self.m1
    200
  end
end
module R
  refine C.singleton_class do
    def m1
      100
    end
  end
end

puts C.m1 #200
using R
puts C.m1 #100


class Human
  NAME = "Unknown"

  def self.name
    const_get(:NAME)
  end
end

class Fukuzawa < Human
  NAME = "Yukichi"
end

puts Fukuzawa.name


module M
  def foo
    super
    puts "M#foo"
  end
end

class C2
  def foo
    puts "C2#foo"
  end
end

class C < C2
  def foo
    super
    puts "C#foo"
  end
  load M
end

C.new.foo


def hoge(*args, &block)
  p args
  p *args
  block.call(*args)
end
hoge(1,2,3,4) do |*args|
  p args
  p args.length > 0 ? "hello" : args
end


class C
  def m1(value)
    100 + value
  end
end

module R1
  refine C do
    def m1
      super 50
    end
  end
end

module R2
  refine C do
    def m1
      super 100
    end
  end
end

using R1
using R2

puts C.new.m1


class Base
  CONST = "Hello, world"
end

class C < Base
end

module P
  CONST = "Good, night"
end

class Base
  # include P
  prepend P
end

module M
  class C
    CONST = "Good, evening"
  end
end

module M
  class ::C
    def greet
      CONST
    end
  end
end

p C.new.greet #gn
p M::C::CONST #ge
p Base::CONST #hw

require 'date'
d = Date.today - Date.new(2015,10,1)
p d.class


class S
  def initialize
    puts "S#initialize"
  end
end

class C < S
  def initialize(*args)
    super()
    puts "C#initialize"
  end
end

C.new(1,2,3,4,5)


val = 100

def m(val)
  yield(15 + val)
end

_proc = Proc.new{|arg| val + arg }

p m(val, &_proc)


