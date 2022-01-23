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
