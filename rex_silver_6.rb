hoge = "a".to_h #error
puts hoge.class

raise ['Error Message'] #typeerror

def hoge(step = 1)
  current = 0
  Proc.new {
    current += step
  }
end
p1 = hoge()
p2 = hoge(2)
p1.call
p1.call
p p1.call #3
p2.call
p2.call
p p2.call #6
