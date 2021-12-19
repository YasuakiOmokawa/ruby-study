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
