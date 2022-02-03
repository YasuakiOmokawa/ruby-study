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


class S
  def initialize(*)
    puts "S#initialize"
  end
end

class C < S
  def initialize(*args)
    super
    puts "C#initialize"
  end
end

C.new(1,2,3,4,5)


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
  prepend M
end

C.new.foo


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
  def method_missing(id, *args)
    puts "B#method_missing"
  end
end

obj = B.new
obj.dummy_method


begin
  print "liberty" + :fish
rescue TypeError
  print "TypeError."
rescue
  print "Error."
else
  print "Else."
end


def foo(a)
  a + yield
end

puts foo("Ruby") { "Examination" }


class C
  @@val = 10
end

module M
  # include B
  # @@val = 20

  class << C
    # p @@val
    def fuga
      p @@val
    end
  end
end

class C
  include M
end
C.fuga


class Foo
  @@a = :a
  class << Foo
    p @@a       #=> :a
  end

  def Foo.a1
    p @@a
  end
end

Foo.a1          #=> :a

def Foo.a2
  p @@a
end
Foo.a2          #=> NameError になります。

class << Foo
  p @@a         #=> NameError になります。
end


class C
  @@val = 10
end

module B
  @@val = 30
end

module M
  include B
  @@val = 20

  class << C
    p @@val
  end
end


class C
  @@val = 10
end

module B
  @@val = 30
end

module M
  prepend B
  @@val = 20

  class << C
    p @@val
  end
end


module M1
end

module M2
end

class C
  include M1, M2
end

p C.ancestors


$num = 0
1..10.times do |n|
  require './require'
end
puts $num

$num = 0
1..10.times do |n|
  load './require.rb'
end
puts $num


m = Module.new

CONST = "Constant in Toplevel"

_proc = Proc.new do
  CONST = "Constant in Proc"
end

m.instance_eval(<<-EOS)
  CONST = "Constant in Module instance"

  def const
    CONST
  end
EOS

m.module_eval(&_proc)

p m.const


def foo(arg1:100, arg2:200)
  puts arg1
  puts arg2
end

option = {arg2: 900}

foo arg1: 200, **option


begin
  print "liberty" + :fish
rescue TypeError
  print "TypeError."
rescue
  print "Error."
else
  print "Else."
ensure
  print "Ensure."
end


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

using M

class K < C
  def m1(value)
    super value - 100
  end
end

puts K.new.m1 400


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
    @@val += 1
    super
  end
end

C.new
C.new
S.new
S.new

p C.class_variable_get(:@@val)


module M1
  class C1
    CONST = '001'.freeze
  end

  class C2 < C1
    CONST = '010'.freeze

    module M2
      CONST = '011'.freeze

      class Ca
        CONST = '100'.freeze
      end

      class Cb < Ca
        p CONST
        #=> "011"
        p Module.nesting
        #=> [M1::C2::M2::Cb, M1::C2::M2, M1::C2, M1]
      end
    end
  end
end


class C
  CONST = 'Good, night'.freeze
end

module M
  CONST = 'Good, evening'.freeze
end

module M
  class C
    CONST = 'Hello, world'.freeze
  end
end

module M
  class C
    p CONST
    #=> "Hello, world"
    p Module.nesting
    #=> [M::C, M]
  end
end


def foo(n)
  n ** n
end

puts foo (2) * 2
puts foo(2) * 2


x = 0
def hoge
  (1...5).each do |_i|
    x += _i #> `block in hoge': undefined method `+' for nil:NilClass (NoMethodError)
  end
  puts x
end
hoge


class Company
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

companies = []
companies << Company.new(2, 'Liberyfish')
companies << Company.new(3, 'Freefish')
companies << Company.new(1, 'Freedomfish')

companies.sort

companies.each do |e|
  puts e
end


class Hoge
  def say(message)
    puts message
  end
end

class Piyo < Hoge
  def say(message)
    super
    puts 'Piyo'
  end
end

p Piyo.new.say('Hello')


class Hoge2
  def say
    puts message
  end
end

class Piyo2 < Hoge2
  def say(message)
    super
    puts 'Piyo'
  end
end

p Piyo2.new.say('Hello')


characters = ["a", "b", "c"]
characters.freeze

characters.each do |chr|
  chr.freeze
end

upcased = characters.map do |chr|
  p chr.object_id
  chr.upcase
  p chr.object_id
end

p upcased
c = 'a'
c.freeze
c = 'b'


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

p C.hoge


v1 = 1 / 2 == 0
v2 = !!v1 or raise RuntimeError
puts v2 and false


module K
  CONST = "Good, night"
  class P
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
  class M::C
    p CONST
  end
end


require 'yaml'

yaml = <<YAML
  sum: 510,
  orders:
    - 260
    - 250
YAML

object = YAML.load yaml

p object


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



def func(hash)
  p hash
  p **hash
end

func {:key => "val"}

hoge = 'a'
def hoge.singleton
  'singleton is'
end
hoge.freeze
p hoge.frozen?
p hoge.singleton
duped = hoge.dup
p duped.frozen?
p duped.singleton
cloned = hoge.clone
p cloned.frozen?
p cloned.singleton


class C
  def func; puts "Hello"; end
end

class Child < C
  undef_method :func
end

class GrandChild < Child
end

C.new.func # => Hello
Child.new.func # => NoMethodError
GrandChild.new.func # => NoMethodError


class C
  def func; puts "Hello"; end
end

class Child < C
  remove_method :func
end

class GrandChild < C
end

C.new.func # => Hello
Child.new.func # => NoMethodError
GrandChild.new.func # => NoMethodError


class C
  def f; puts "World"; end
end

class Child < C
  def f; puts "Hello"; end
end

child = Child.new
puts child.f

Child.class_eval { remove_method :f }

puts child.f


class String
  alias_method 'hoge', 'reverse'
  alias hoge2 reverse
end


class Company
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
    other.id <=> self.id
  end
end

companies = []
companies << Company.new(2, 'Liberyfish')
companies << Company.new(3, 'Freefish')
companies << Company.new(1, 'Freedomfish')

companies.sort!

companies.each do |e|
  puts e
end


enum_char = Enumerator.new do |yielder|
  "apple".each_char do |chr|
    yielder << chr
  end
end

array = enum_char.map do |chr|
  chr.ord
end

p array


def foo(arg1:100, arg2:200)
  puts arg1
  puts arg2
end

option = {arg2: 900}

foo arg1: 200, *option


module SuperMod
end

module SuperMod::BaseMod
  p Module.nesting
end


array = ["a", "b", "c"].freeze

array.each do |chr|
  chr.upcase!
end

p array

array.first.freeze
array.first.upcase!



class C
  def call_protected
    protected_method
  end

  def with_receiver
    self.protected_method
  end

  def with_receiver_private
    self.private_method
  end

  protected

  def protected_method; "protected"; end

  private

  def private_method; 'private'; end
end

p C.new.protected_method
p C.new.call_protected
p C.new.with_receiver
p C.new.with_receiver_private


a = 1 + "(1/2r)".to_r
p a.class # => Rational

a = a + 1.0
p a.class # => Float

a = a + "(1/2r)".to_r
p a.class # => Float

a = a + "(1 + 2i)".to_c
p a.class # => Complex

a = a + '(1/2r)'.to_r # Complex
p a.class


module M
  def class_m
    "class_m"
  end
end

class C
  include M
end

p C.methods.include? :class_m

def keys(x:, y: 123)
  p x
  p y
end
keys(y: 456)
