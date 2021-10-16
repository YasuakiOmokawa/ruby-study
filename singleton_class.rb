# singleton class is a specialized class attached in instance
class Foo
  def initialize(a)
    @a = a
  end
end
foo1 = Foo.new(1)
foo2 = Foo.new(1)
def foo1.methodB
  'B'
end
p foo1.methodB #B
p foo2.methodB #error

# include module into instance
require './bar'
foo1 = Foo.new(1)
foo2 = Foo.new(1)
foo1.extend(Bar)
foo1.methodA #A
foo2.methodA #error
