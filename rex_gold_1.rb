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