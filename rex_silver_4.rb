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

