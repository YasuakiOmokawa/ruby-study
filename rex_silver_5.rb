a = "Ruby"
b = " on Rails"
a.concat b
a.reverse!
p a.index("R", 1) #4

X = 10
Y = X < 10 ? "C" : "D" #定数を動的に定義できないのでエラー
puts Y

h = Hash({})
h.class
p h.merge({a: 10})
p h

str = "1;2:3;4"
p str.split(";|:")
p str.split(/;|:/)

a = "Ruby"
b = " on Rails"
a.concat b
a.reverse
p a.index("R", 1) #8

a = [1, 2, 3, 4, 5]
b = [2, 4, 6]
(a - b).map(&:next)
a && b

str = "abcdefgh"
puts str[4..6]
puts str[-3..6]
puts str[4...-1]

