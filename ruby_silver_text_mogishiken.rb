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
