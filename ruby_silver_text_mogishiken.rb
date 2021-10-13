#m1
while
class

#m2
x = 0
[1,2,3].each do |x|
  print x.to_s + " "
end
puts x
#1 2 3 0

#3
nil || 'hoge'
false || 'fuga'

#4
y = false
y && (raise 'falied')
puts ('succeeded!')

#5
(1..10).each do |i| puts i end #1~10
(1...10).each do |i| puts i end #1~9

#6
HOGE = 'hoge'
HOGE.gsub!('hoge', 'piyo') #NO warning
print HOGE #piyo

#8
begin
  puts 10/0
rescue ZeroDivisionError => ex
  print 'ZeroDivisionException:', ex.message
end

#9
p ?A #A

#10
class Hoge < Object; end #ok
class Fuga < Kernel; end #error

#m11
class Parent
  attr_reader :name
  def initialize name
    @name = name
  end
end
class Child < Parent
  def initialize name
    @name = "Child#{name}"
  end
end
puts Child.new('Hoge').name #ChildHoge

#m12
class Integer
  def to_square
    return self * self
  end
end
print 4.to_square #16

#m13
p '12abc'.to_i #12

#14
a = [1,2,3,4]
p a[1...3] #[2,3]

#15
a = [1,2,3,4,5]
p a[2..-1] #[3,4,5]

#16
a = 1,2,3
a.join(',')

#17
s = 'a;b:c;d:e;f'
p s.split(/:|;/)

#18
a = [1,2,3]
b = [1,3,5]
c = a
a = b & c
p a + b + c

#19
a = [1,2,3,4]
b = [1,3,5,7]
p a || b #[1,2,3,4]

#20
def sum(*a)
  total = 0
  a.each {|i| total += i}
  return total
end
puts sum(1,2,3,4,5)

#21
a = [1,2,3]
b = [1,3,5]
c = [2,3,4]
p a+b-c #[1,1,5]

#22
a = [0, 1, 2, 3, 4, 5]
a.delete_if{|x| x % 2 == 0}
p a #=> [1, 3, 5]

b = [0, 1, 2, 3, 4, 5]
b.reject!{|x| x % 2 == 0}
p b #=> [1, 3, 5]

#23
a = [:a,:b,:c,:d]
a.each_with_index {|item,i| print "#{i}:#{item}\n"}

#24
s = %w[a b c]
s.shift
s.shift
s.unshift
s.push 'd'
p s #[c,d]

#25
a =[:a,:a,:b,:c]
a[5] = :e
a.concat [:a,:b,:c]
a.compact
a.uniq
p a # [:a,:a,:b,:c,nil,:e,:a,:b,:c]