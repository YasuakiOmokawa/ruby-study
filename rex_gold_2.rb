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


def foo(arg2: 1, arg1: 10)
  p arg1
  p arg2
end
option = {arg2: 900}
p foo option
foo **option
