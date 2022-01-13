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
