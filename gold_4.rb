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


