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
