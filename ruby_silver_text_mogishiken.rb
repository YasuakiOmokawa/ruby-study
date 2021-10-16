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

#26
p [1, 2, 3, 4, 5].find {|i| i % 3 == 0 }   # => 3
p [1, 2, 3, 4, 5].detect {|i| i % 3 == 0 }   # => 3

#27
a = [1,2,3]
p a.collect {|v| v*2} #[2,4,6]
p a.map {|v| v*2} #[2,4,6]

#28
sa = %w(a b c)
sa.each {|v| print "#{v} "}

#29
a = %w[a b c]
b = [*1..3]
a.zip(b).each {|x| p x} #[a,1],[b,2],[c,3]

#30
s = <<EOB
i am
a boy
EOB
p s

#32
a = 'Ruby'
b = 'Rails'
b = a
a.upcase
print b #Ruby

#33
p 'find!find!'.index('!',5) #9

#34
x = 'Hello, World.\n'
x.chop #Hello, World.
x.chop #Hello, World.
x.chomp #Hello, World.
p x #Hello, World.\n

#35
a = 'abcdefghijk'
a[1,3] = 'x'
print a,'\n' #axefghijk
b = 'abcdefghijk'
b[1..3] = 'x'
print b,'\n' #axefghijk

#36
'hogepiyohogehoge'.slice(/o../) #oge

#37
puts '0123456789-'.delete('^13-56-') #13456-

#38
'123'.match(/^[0-9][0-9]*$/) #123
'12a3'.match(/^[0-9][0-9]*$/) #nil
'123a'.match(/^[0-9][0-9]*$/) #nil
''.match(/^[0-9]*$/) #match ''

#39
p 'ab 123 gg 456 dd'.scan(/\d+/).length #2

#40
p 65.chr #A
p 'A'.ord #65

#41
p 'HogeHOGEhoge'[%r![A-Z][^A-Z]+!] #Hoge

#42
h = {'a': 1, 'b': 2}
p h #{:a => 1, :b => 2}

#43
h = {1 => 'a', 2 => 'b'}
p h.invert #{'a' => 1, 'b' => 2}

#44
h = {1 => 'a', 2 => 'b'}
h.reject {|x, y| x < 2} #{2 => 'b'}
p h #{1 => 'a', 2 => 'b'}

#45
a = {'Foo' => 'Hoge', 'Bar' => 'Piyo', 'Baz' => 'Fuga'}
b = {'Foo' => 'hoge', 'Bar' => 'piyo', 'Baz' => 'fuga'}
a.update(b).sort{|a,b| a[1] <=> b[1]}

#47
open('test.txt', 'r+') do |f|
  data = f.read.chomp
  data.reverse!
  f.rewind
  f.write data
end

#48
puts File.join('/', 'usr','bin') #/usr/bin

#49
t = Time.local(2000,1,1)
print t.strftime('%Y/%m/%d') #2000/01/01

#50
t1 = Time.gm(2010,1,1,0,0)
t2 = Time.gm(2010,1,1,0,1)
p t2 - t1 #60.0
