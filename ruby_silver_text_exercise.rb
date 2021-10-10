# https://www.amazon.co.jp/%EF%BC%BB%E6%94%B9%E8%A8%822%E7%89%88%EF%BC%BDRuby%E6%8A%80%E8%A1%93%E8%80%85%E8%AA%8D%E5%AE%9A%E8%A9%A6%E9%A8%93%E5%90%88%E6%A0%BC%E6%95%99%E6%9C%AC%EF%BC%88Silver-Gold%E5%AF%BE%E5%BF%9C%EF%BC%89Ruby%E5%85%AC%E5%BC%8F%E8%B3%87%E6%A0%BC%E6%95%99%E7%A7%91%E6%9B%B8-%E7%89%A7-%E4%BF%8A%E7%94%B7-ebook/dp/B0756VF9Y3/ref=tmm_kin_swatch_0?_encoding=UTF8&qid=1633346406&sr=8-1

#1
1,2,4

#2
x = 0
def hoge
  (1..5).each do |i|
    x += 1
  end
  puts x
end
hoge # exception

#3
# Error.
# Ensure.
begin
  puts 1+'2'
rescue
  puts 'Error'
rescue TypeError
  puts 'Type Error.'
ensure
  puts 'Ensure.'
end

#4
puts 090 # error

#5
x = 10
y = x < 10 ? "A" : "B"
puts y #B

#6
MAX=10
print MAX #10
MAX=100 #warning
print MAX #100

#7
def foo(*a)
  p a
end
foo(1,2,3) #[1,2,3]

#8
1,2,4

#9
class Hoge
  attr_reader: :message

  def initialize
    @message = 'Hello'
  end
end
class Piyo < Hoge
  def initialize
    @message = 'Hi'
    super
  end
end
puts Piyo.new.message #Hello

#10
include Math
def area r
  return r * r * PI
end
area 3

def area r
  return r * r * Math::PI
end
area 4

#11
2,5

#12
s = 'Hello'
def s.greet
  puts 'Hi'
end
class String
  def greet
    puts 'Hello'
  end
end
s.greet #Hi

#13
class Employee
  attr_reader :id
  attr_accessor :name

  def initialize id, name
    @id = id
    @name = name
  end
  def to_s
    return "#{@id}:#{@name}"
  end
  def <=> other
    return self.id <=> other.id
  end
end
employees = []
employees << Employee.new('3', 'tanaka')
employees << Employee.new('2', 'suzuki')
employees << Employee.new('1', 'sato')
employees.sort!
employees.each { |e| puts e }

#14
a = [1,2,3,4]
b = [1,3,5,7]
c = a & b
c.each {|i| print i, ' '}

#15
a = [1,2,3,4]
a[0..-2].each { |i| print i, ' ' }

a[0,3].each { |i| print i, ' ' }

#16
1,2

#17
a1 = %w(a b)
a2 = %w(x y)
a3 = a1.zip(a2)
a3.first #[a,x]

#18
a = [1,2,3,4,5]
p a.slice(1,3) #[2,3,4]

#19
a = 'abc'
b = 'abc'
print a.eql? b #true
print a.equal? b #false
print a == b #true

#20
puts 5 + 'Hello' #error
puts 'Hello' + 5 #error
puts 'Hello' * 5 #not error
puts 5 * 'Hello' #error

#21
s = <<"EOB"
Hello,
Ruby
World.
EOB
"EOB"
p s #Hello, Ruby World.

#22
s1 = 'Hoge'
s2 = 'Fuga'
s1.concat(s2) #HogeFuga
s1.chop #HogeFug
s1.chomp #HogeFug
s1+s2
p s1 #HogeFuga

#23
s = '123456789'
p s[1,4] #2345

#24
member = [10, 'Tanaka']
print "ID:%2d Name:%s" % member #ID:10 Name:Tanaka

#25
h = {}
{a: 1,b:2}.invert #{1: :a,2: :b}
#1,3