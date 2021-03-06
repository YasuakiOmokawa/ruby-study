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

def bar(n)
  puts n
end
bar 5
bar (10)

def bar(*n1, n2)
  puts n1
  puts n2
end
bar 5, 6, 7, 8

def bar(*n1, n2, *n3) #error 可変長引数は1つしか指定できない
  puts n1
  puts n2
end
bar 5, 6, 7, 8

def foo(n)
  n ** n
end
puts foo (2) * 2 #256 *が先に評価されるため、 foo(4)と同じ
puts foo(2) * 2 #8 ()が先に評価される

h = {a: 100}
h.each {|p|
  p p #[:a, 100]
  p p.class #array
}

def hoge
  x = 0
  1.step(5,1) do |i| #1から5まで1ずつインクリメント
    x += 1
  end
  puts x
end
hoge

h = Hash.new("default value")
h[:a]
h[:b] = 100
p h

def hoge
  x = 10
  Y = x < 10 ? "C" : "D" #メソッドの定義内で定数を定義できない
  puts Y
end
hoge

str = "1;2;3;4"
p str.split(";")

arr = [
  true.equal?(true), #true 1
  nil.eql?(NilClass), #false 2
  String.new.equal?(String.new), #false 2
  1.equal?(1) #true 1
]
p arr.collect { |a| a ? 1 : 2 }.inject(:+) #6

x = %(a b)
y = %W(c d)
z = y << x
p z

IO.read("text.txt", 3, offset = 1) #2行目から3行取得と予想 -> 2バイト目から3バイト取得 Ex\n

v1 = false || 1 + 1 == 1.to_i #1+1が先に算出されると予想 false -> ○ 算出演算子のほうが優先度が高い
puts v1


arr = [["apple"],["banana"],["orange"]].flatten
arr.each do |i|
  puts i
end