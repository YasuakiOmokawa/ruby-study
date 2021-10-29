def hoge(n)
  if n % 3 == 0
    "hello"
  elsif n % 5 == 0
    "world"
  end
end
str = ''
str.concat hoge(3)
str.concat hoge(5)
puts str #helloworld

module IntegerExt
  refine Integer do
    def foo
      self + 2
    end
  end
end
using IntegerExt; p 1.foo #3

p [1, 2, 3].inject{|x, y| x + y ** 2} rescue p $!
p [1, 2, 3].inject(0){|x, y| x + y ** 2} rescue p $!
p [1, 2, 3].inject([]){|x, y| x << y ** 2} rescue p $!
p [1, 2, 3].inject do|x, y| x + y ** 2 end rescue p $!

a = [1, 2, 3, 4]
p a[1..2] #[2,3]

def foo(n)
  n ** n
end
puts foo (2) * 2 #4^4 = 4 * 4 * 4 * 4 = 256

a1 = "abc"
a2 = 'abc'
print a1.eql? a2
print a1 == a2
# truetrue

hoge = 0
def hoge
  x = 0
  5.times do |i|
    x += 1
  end
  x
end
puts hoge

a = [1]
a[5] = 10
a.compact!
p a #[1,10]

str = "abcdefghijk"
p str[2...4] #cd

$val = 0
class Count
  def self.up
    $val = $val + 1
    $val == 3 ? true : false
  end
end
[*1..10].select do
  Count.up
end
p $val #3

a = [1, 2, 5, 7, 8]
b = [1, 3, 6, 7, 9]
c =  nil || a & b | a && a | b # [1,7] | [1,2,5,7,8] | [1,3,6,7,9] = [1,2,3,5,6,7,8,9]
p c


p [1,2,3,4,5].partition(&:odd?) == [1,2,3,4,5].partition { |value| value.odd? }

arr = ["c", 2, "a", 3, 1, "b"]
arr.sort # stringと数値はソートできない

a = [1, 2, 3, 5, 8]
b = [1, 3, 6, 7, 8]
c = false || true ? true && false ? a | b : a & b : b ;
p c #[1,3,8]

0.upto(5).select(&:odd?) #[1,3,5]

hoge = 0
def hoge
  x = 0
  5.times do |i|
    x += 1
  end
  x
end
puts hoge #変数のほうが先に探索されるので0

def hoge(n)
  unless n != 3
    "hello"
  elsif n == 5 #unless にelsifは使えない。error
    "world"
  end
end
str = ''
str.concat hoge(3)
str.concat hoge(5)
puts str

$val = 0
class Count
  def self.up
    $val = $val + 1
    $val == 3 ? true : false
  end
end
#selectは、ブロックのtrue/falseに関わらずレシーバオブジェクトをすべて走査するので、10
#これが仮に#any?だったら、falseになったらレシーバオブジェクトの走査が終了するため、3
[*1..10].select? do
  Count.up
end
p $val

