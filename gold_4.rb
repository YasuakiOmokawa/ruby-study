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

enum = "apple".split('').enum_for
enum = "apple".to_enum(:each_char)

p enum.next
p enum.next
p enum.next
p enum.next
p enum.next


class C
  class << self
    @@val = 10
  end
end

p C.class_variable_get(:@@val)

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


_proc = Proc.new {
  p Module.nesting
}

_proc.call # [] が表示されます

m = Module.new

m.instance_eval(<<-EVAL)
  p Module.nesting # [#<Class:#<Module:0x007fe71194e210>>] と表示されます
EVAL

m.instance_eval {
  p Module.nesting # [] と表示されます
}


begin
  print "liberty" + :fish
rescue TypeError
  print "TypeError."
rescue
  print "Error."
else
  print "Else."
end #TypeError


v1 = 1 / 2 == 0
v2 = !!v1 or raise RuntimeError
puts v2 and false

puts true and false
puts false and true
puts true and 'hoge'


def foo(arg1:100, arg2:200)
  puts arg1
  puts arg2
end

option = {arg2: 900}

foo arg1: 200, *option


module M
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def class_m
      "M.class_m"
    end
  end
end

class C
  include M
end

p C.methods.include? :class_m


module Bar
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def bar
      puts "bar"
    end
  end
end

class Foo
  include Bar
end

Foo.bar #=> bar


begin
  raise "Err!"
rescue => e
  puts e.class
end


class S
  def initialize
    puts "S#initialize"
  end
end

class C < S
  def initialize(*args)
    super() # 引数なしを明示的に指定する
    puts "C#initialize"
  end
end

C.new(1,2,3,4,5)

module M
  p Module.nesting # [M]
end

M.module_eval(<<-EVAL)
  p Module.nesting # [M]
EVAL

M.instance_eval do
  p Module.nesting # []
end

module M
  p Module.nesting # [M]
end

f = Fiber.new do |name|
  Fiber.yield "Hi, #{name}"
end

p f.resume('Matz') # 'Hi, Matz'と表示されます。
f.resume('hoge')

f = Fiber.new do |total|
  Fiber.yield total + 10
end

p f.resume(100) + f.resume(5)


array = ["a", "b", "c"].freeze
array << "d" # 例外発生

p array
array.each do |char|
  char.upcase!
end
p array


ls Kernel

Const = "top"

module M
  Const = "m"
end

class C1
  include M

  def c1
    ::Const
  end
end

class C2
  def c2
    M::Const
  end
end

class C3 < C1
end

p C1.new.c1 # => "top"
p C2.new.c2 # => "m"
p Const     # => "top"
p M::Const  # => "m"
p C1::Const # => "m"
p C3::Const # => "m"


class Foo
  @var = 1

  def initialize
    @var = 2
  end

  def var
    @var
  end

  def self.var
    @var
  end
end

p Foo.var     # => 1
p Foo.new.var # => 2


class Foo
  @var = 1
end

def Foo.var
  @var
end

p Foo.var     # => 1


class Foo
  @var = "Ruby"

  def self.var
    "#{@var} / Examination"
  end
end

class Baz < Foo
end

p Foo.var # => "Ruby / Examination"
p Baz.var # => " / Examination"

