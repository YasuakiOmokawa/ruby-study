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
