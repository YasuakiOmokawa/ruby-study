# rex gold 1

p (1..10).lazy.map{|num|
  num * 2
}.take(3).inject(0, &:+) #12

p (1..10).map{|num|
  num * 2
}.take(3).inject(0, &:+) #12

module M
  def class_m
    "class_m"
  end
end

class C
  include M
end

p C.methods.include? :class_m #false

class C2
  class << self
    include M
  end
end
p C2.methods.include? :class_m #true
p C2.singleton_methods(false).include? :class_m #false
p C.new.methods.include? :class_m #true
# moduleをincludeすると、defはインスタンスメソッドなのでクラスのmethodsでは応答しない。
# newするか、特異メソッドとしてincludeしてやれば応答できる。

class A
  HOGE = 'A'
end
module B
  HOGE ='B'
  class C < A
    def hoge
      puts HOGE
    end
  end
end
B::C.new.hoge #B

class A
  def hoge
    'メソッド探索はスーパークラスのみ実施する'
  end
end
module B
  def hoge
    'レキシカルスコープ'
  end
  class C < A
    def fuga
      hoge
    end
  end
end
p /メソッド探索はスーパークラスのみ実施する/.match?(B::C.new.hoge)

class A
  def hoge
    fuga
  end
end
class B < A
  def fuga
    'スーパークラスでサブクラスのメソッドは問題なく呼べる'
  end
end
p /スーパークラスでサブクラスのメソッドは問題なく呼べる/.match? B.new.hoge

class A
  HOGE = 'A'
  def hoge
    HOGE
  end
end
class B < A
  HOGE = 'B'
end
p /A/.match? B.new.hoge

class A2
  def hoge
    HOGE
  end
end
class B < A2
  HOGE = 'B'
end
p B.new.hoge #uninitialized constant A2::HOGE

module D
  module E
    B.class_eval do
      def fuga
        puts self
        puts HOGE
      end
    end
  end
end
p B.new.fuga

class A
  def hoge
    B::HOGE
  end
end
class B < A
  HOGE = 'B'
end
p B.new.hoge #B

class A
  HOGE = "hoge"
end
class B < A
  def hoge
    puts A::HOGE #hoge
    puts B::HOGE #error
    puts HOGE #error
  end
end
p B.new.hoge

class C
  class << C
    def hoge
      'Hi'
    end
  end

  def hoge
    'Goodbye'
  end
end
p C.new.hoge #Goodbye

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
p C.class_variable_get(:@@val) #2

class C
  def initialize
    p self.class
  end
end
class C2 < C
end
C2.new #C2

module M1
end
module M2
end
class C
  include M1
  include M2
end
p C.ancestors

val = 1 + 1/2r
puts val.class #Rational

def m1(*args)
  p args
  str = yield if block_given?
  p "m1 #{str}"
end
def m2(*args)
  p args
  str = yield if block_given?
  p "m2 #{str}"
end
m1 m2 do
  "hello"
end
def m3(*)
end
def m4
  p 'hoge'
end

module M
  def class_m
    "class_m"
  end
end
class C
  extend M
end
p C.methods.include? :class_m #true

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
B.new.dummy_method #A#method_missing

class Human
  NAME = "Unknown"

  def self.name
    const_get(:NAME)
  end
end
class Fukuzawa < Human
  NAME = "Yukichi"
end
puts Fukuzawa.name #Yukichi
class Mishima < Fukuzawa
  NAME = 'Yukio'
end
puts Mishima.name

module M1
end
module M2
end
class C
  include M1, M2
end
p C.ancestors

class C1
  NAME = 'hoge'
end
class C1
  def self.name
    NAME
  end
end
p C1.name #hoge

module M
  CONST = "Hello, world"
end
class << M
  def say
    const_get(:CONST)
  end
end
p M::say #Hello, world

module M
  CONST = "Hello, world"
end
class << M
  def say
    CONST
  end
end
p M::say #error

p [1,2,3,4].map(&self.method(:*)) #error
p self.method(:puts)
p [1,2,3,4].map(&self.method(:puts)) #[nil,nil,nil,nil]

module A
  B = 42

  def f
    21
  end
end
A.module_eval(<<-CODE)
  def self.f
    p B
  end
CODE
B = 15
A.f #42

def foo(arg1:100, arg2:200)
  puts arg1
  puts arg2
end
option = {arg2: 900}
foo arg1: 200, **option # 200 900

class Base
  CONST = "Hello, world"
end
class C < Base
end
module P
  CONST = "Good, night"
end
class Base
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
p C.new.greet

class C3
  CONST = 'c3'
end
class C2 < C3
  def const
    CONST
  end
end
p C2.new.const
module M2
  CONST = 'm2'
end
class C3
  prepend M2
end
p C2.new.const

module M3
  CONST = 'm3'
end
class C4
  prepend M3

  def say
    CONST
  end
end
C4.new.say #レキシカルスコープに入った？

module M2
  CONST = 'm2'
end
class C3
  # CONST = 'c3'
end
class C2 < C3
  def const
    CONST
  end
end
class C3
  prepend M2
end
p C2.new.const #m2 moduleのprependにより、無名クラスを参照しようとする

m = Module.new
CONST = "Constant in Toplevel"
_proc = Proc.new do
  CONST = "Constant in Proc"
end
m.module_eval(<<-EOS)
  CONST = "Constant in Module instance"

  def const
    CONST
  end
EOS
m.module_eval(&_proc)
p m.const #Constant in Module instance
c = Class.new.include(m)
c.new.const

def hoge(*args, &block)
  p "args-hoge is #{args}"
  block.call(args)
end
hoge(1,2,3,4) do |*args|
  p "args-block is #{args}"
  p args.length < 0 ? "hello" : args
end

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
  include M
end
C.new.foo

mod = Module.new
mod.module_eval do
  EVAL_CONST = 100
end
puts "EVAL_CONST is defined? #{mod.const_defined?(:EVAL_CONST)}"
puts "EVAL_CONST is defined? #{Object.const_defined?(:EVAL_CONST)}"

v1 = 1 / 2 == 0
v2 = !!v1 or raise RuntimeError
puts v2 and false

def foo(n)
  n ** n
end
foo = Proc.new { |n|
  n * 3
}
puts foo[2] * 2

module M
  @@val = 75
  class Parent
    @@val = 100
  end
  class Child < Parent
    @@val += 50
  end

  # if Child < Parent
  if 100 > 10
    @@val += 25
  else
    @@val += 30
  end

  def self.hoge
    if Child < Parent
      # if true
        @@val += 25
      else
        @@val += 30
      end
  end
end
p M::Child.class_variable_get(:@@val)

def bar(&block)
  # block.call
  block.yield
end
bar do
  puts "hello, world"
end
proc = Proc.new { 'this is proc' }
proc.call
proc.yield
proc[]
proc.()

class C;end
class K < C
  def hoge(value)
    super value
  end
end
K.new.hoge 100 #100

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
puts C.new.m1 400 #300
using M
class K < C
  def m1(value)
    super value - 100
  end
end
puts K.new.m1 400 #100 refine + superは、refineでオーバーライドされたメソッドを呼び出す

p "Matz is my tEacher".scan(/[is|my]/).length #4
p "Matz is my tEacher".scan(/is/)
p "Matz is my tEacher".scan(/[is]/)

val = 0
class B
end
class C < B
end
if C < BasicObject
  val += 100
else
  val += 15
end
if B < C
  val += 100
else
  val += 15
end
p val

class C
end
p C.singleton_class.singleton_class.singleton_class.singleton_class

class Company
  include Comparable
  attr_reader :id
  attr_accessor :name
  def initialize id, name
    @id = id
    @name = name
  end
  def to_s
    "#{id}:#{name}"
  end
  def <=> other
    self.id <=> other.id
  end
end
c1 = Company.new(3, 'Liberyfish')
c2 = Company.new(2, 'Freefish')
c3 = Company.new(1, 'Freedomfish')
print c1.between?(c2, c3)
print c2.between?(c3, c1)

# if (cmpint(x, min) < 0) return Qfalse; 3 > 2 && 3 < 1 = false, 3 < 2 && 3 > 1 = false
# if (cmpint(x, max) > 0) return Qfalse; 2 > 1 && 2 < 3 = true, 2 < 1 && 2 > 3 = false

$num = 0
1..10.times do |n|
  p load './lib.rb'
end
puts $num

$num = 0
1..10.times do |n|
  p require './lib.rb'
end
puts $num

mod = Module.new
mod.module_eval do
  EVAL_CONST = 100
end
puts "EVAL_CONST is defined? #{mod.const_defined?(:EVAL_CONST, false)}"
puts "EVAL_CONST is defined? #{Object.const_defined?(:EVAL_CONST, false)}"

a = nil
f = Fiber.new do
  p 'fiber do'
  a = Fiber.yield()
  p a
  p 'fiber done'
end
f.resume()
f.resume(:foo)
f.resume()
p a  #=> :foo

class Base
  def name
    p 'Base#name'
  end
end

module Scope
  class Base
    def name
      p 'Scope::Base#name'
    end
  end
  class Inherited < Base
    def name
      p 'Scope::Inherited#name'
      super
    end
  end
end
inherited = Scope::Inherited.new
inherited.name

module M
  def hoge
    __method__
  end
end
class C
  include M
end
module M2
  def m2
    'm2'
  end
end
module M
  include M2
end
p C.new.hoge
p C.new.m2

module M1
  def method_1
    __method__
  end
end
class C
  include M1
end
p C.new.method_1
module M2
  def method_2
    __method__
  end
end
module M1
  include M2
end
p C.new.method_2

p "Matz is my tEacher"[/[J-P]\w+[^ ]/]

def foo(a)
  a + yield
end
puts foo("Ruby") { "Examination" }

lazy = (1..100).each.lazy.chunk(&:even?)
lazy.first(5)
lazy.take(5).force

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
m1 m2 {
  "hello"
}


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

using R

puts C.m1


class Human
  NAME = "Unknown"
end
class Fukuzawa < Human
  # NAME = "Yukichi"
  def self.name
    const_get(:NAME)
  end
end
puts Fukuzawa.name


module A
  B = 42

  def f
    21
  end
end

A.module_eval do
  p Module.nesting
  def self.f
    p B
  end
end

B = 15

A.f


def foo(arg1:100, arg2:200)
  puts arg1
  puts arg2
end

option = {arg2: 900}

foo(arg1: 200, {arg2: 900})


class Base
  CONST = "Hello, world"
end

class C < Base
end

module P
  CONST = "Good, night"
end

class Base
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
      Object.const_get(:CONST)
    end
  end
end

p C.new.greet


m = Module.new

CONST = "Constant in Toplevel"

_proc = Proc.new do
  CONST = "Constant in Proc"
  def proc2
    CONST
  end
  module_function :proc2
end

m.module_eval(<<-EOS)
  CONST = "Constant in Module instance"

  def const
    CONST
  end
EOS

m.module_eval(&_proc)
p m.proc2
p m.const

m.module_eval do
  def fuga
    'fuga'
  end
  module_function :fuga
end
p m.fuga

m.instance_eval do
  CONST2 = 'HOGE'
  def hoge
    CONST2
  end
end
p m.hoge


module SuperMod
  p Module.nesting
end

module Mod
  module Base
    p Module.nesting
  end
end

module Mod::Base
  p Module.nesting
end

A = "top level"
module XML
  A = "module level"
  class SAXParser
    puts A # module level

    def self.a
      "defined in a class in a module"
      puts A
    end
  end
end

class XML::SAXParser
  puts A # top level
  puts a # defined in a class in a module
end
p XML::SAXParser.a
p XML::SAXParser::A
p XML::A


module A
  B = 42

  def f
    21
  end
end

A.module_eval do
  def self.f
    p B
  end
end

B = 15

A.f

A.module_eval(<<-EOS)
  def self.b
    p B
  end
EOS
A.instance_eval do
  def c
    p B
  end
end
A.module_eval do
  def d
    p B
  end
  module_function :d
end
A.module_eval(<<-EOS)
  def e
    p B
  end
  module_function :e
EOS

module A
  C = 'CC'
  module B
  end
end

A::B.module_eval do
  p Module.nesting
  def self.f
    C
  end
end
A::B.f
B.module_eval do
  p Module.nesting
  def self.f
    C
  end
end

def fuga(*args, &block)
  p "function args -> #{args}"
  block.call(args)
end

fuga(1,2,3,4) do |**args|
  p "block called args -> #{args}"
  p args.length
  p args.length <= 1 ? "hello" : args
end


v1 = 1 / 2 == 0
v2 = !!v1 || raise RuntimeError
puts v2 and false
puts false or 'hoge'


module M
  p 'set 1'
  @@val = 1
  @@val2 = 100

  class Parent
    p 'set 2'
    @@val = 2
  end

  class Child < Parent
    p 'plus 3'
    @@val += 3
  end

  if Child < Parent
    p 'plus 1'
    @@val += 1
  else
    p 'plus 30'
    @@val2 += 30
  end

  class Child2 < Child
    @@val += 10
  end
end
p M::Child.class_variable_get(:@@val) #15
p M.class_variable_get(:@@val) #2
p M::Parent.class_variable_get(:@@val) #15
p M.class_variable_get(:@@val2) #100
p M::Child2.class_variable_get(:@@val2) #nameerror


class C
end

class C
  def m1(value)
    p 'in C'
    value - 100
  end
end

class K < C
  def m1(value)
    p 'in K'
    super value - 100
  end
end

module M
  refine K do
    def m1(value)
      p 'in M::K'
      super value - 100
    end
  end
end

using M

puts K.new.m1 400


class Array
  def succ_each(step = 1)
    return to_enum(__method__, step) unless block_given?

    each do |int|
      yield int + step
    end
  end
end

[97, 98, 99].succ_each.map {|int|
  p int.chr
}

[97, 98, 99].succ_each do |i|
  p "block given #{i + 10}"
end
[97, 98, 99].succ_each do |i|
  p "block jamming #{i + 20}"
end

peoples = Enumerator.new do |p|
  p << 'p1'
  p << 'p2'
  p << 'p3'
end
loop { p(peoples.next) }

arrs = [
  {p: 'p1',b: 'b1'},
  {p: 'p2',b: 'b2'},
  {p: 'p3',b: 'b3'},
]
a_b_pairs = Enumerator.new do |y|
  arrs.each do |arr|
      y << [arr[:p], arr[:b]]
  end
end
results = a_b_pairs.map.with_index(1) do |(a, b), i|
  "#{i}: 『#{b}』 #{a}"
end
results.each do |result|
  puts result
end

require 'json'

json = <<JSON
{
  "price":100,
  "order_code":200,
  "order_date":"2018/09/20",
  "tax":0.8
}
JSON

using_parse = JSON.parse json
p using_parse

using_load = JSON.load json
p using_load


class Base
  def name
    p 'Base#name'
  end
end

module Scope
  class Base
    def name
      p 'Scope::Base#name'
    end
  end

  class Inherited < Base # トップレベルにあるクラスBaseとして解釈される
    def name
      p 'Scope::Inherited#name'
      super
    end
  end
end

inherited = Scope::Inherited.new
inherited.name


module M1
  def method_1
    __method__
  end
end

class C
  include M1 # モジュールM2が既に継承関係にある
end

p C.new.method_1
p C.ancestors

module M2
  def method_2
    __method__
  end
end

module M1
  include M2
end

p C.ancestors
p C.new.method_1 # method_1と表示される
p C.new.method_2 # method_2と表示される
