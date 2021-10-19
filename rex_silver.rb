begin
  raise StandardError.new
rescue => e
  puts e.class
end
#StandardError

raise ['message'] # type error

h = {a: 100}
h.clear
p h #{}

open('test.txt', 'r+') do |f|
  data = f.read.upcase
  f.rewind
  f.puts data
end
=begin
AA 1
BB 2
=end

arr = [1,2].product [3,4]
p arr #[[1,3],[1,4],[2,3],[2,4]]

p [1,2,3,4].map do |e| e*e end #p で全体を出すので<Enumrator..>
p [1,2,3,4].map {|e| e*e} #{}は結びつきが強いので [1,4,9,16]

(10..15).to_a.map.with_index(1) do |v,i|
  puts i
end

arr = (1..30).to_a
container = []
arr.each_cons(7) do |i|
  container << i
end
container.size #24 重複ありの繰り返し
c2 = []
arr.each_slice(7) do |i|
  c2 << i
end
c2.size #5 重複なしの繰り返し

p 'Hello' % 5 #stringの%はフォーマット、フォーマット記載がないのでHello
p 'i=%s' % 'Hello' #i=Hello

a = [1]
a[5] = 10
a.compact
p a #[1,nil, nil, nil,nil,10]

def hoge(n)
  unless n != 3
    'hello'
  elsif n == 5
    'world'
  end
end
str = ''
str.concat hoge(3)
str.concat hoge(5)
puts str
# unlessにelsifは指定できないのでエラー

File.open('testfile.txt', 'a+') do |f|
  f.write("recode 1\n")
  f.seek(0, IO::SEEK_SET)
  f.write("recode 2\n")
end

arr = Array.new(3){'a'}
arr.first.upcase!
p arr #['A','a','a']

def foo(n)
  n ** n
end
puts foo(2) * 2 #8

hoge = *"a"
puts hoge.class #String

str = "abcdefghijk"
p str[2,4] #cdef

arr = %w[apple banana orange].reverse
arr.each do |i|
  puts i
end

s = ["one", "two", "three"]
s.shift
s.shift
s.unshift
s.push "four"
p s #[three, four]

s = ["one", "two", "three"]
s.pop
s.pop
s.unshift
s.push "four"
p s #[one, four]

s = <<-EOF
      Hello,
      Ruby
      EOF
p s # Hello,\n Ruby\n

a = "Ruby"
b = " on Rails"
a.append b #appendはArrayのメソッドなのでerror
a.reverse
p a.index("R", 1)

a = "Ruby"
b = " on Rails"
a.concat b
a.reverse
p a.index("R", 1) #reverseで非破壊メソッドなのでRuby on Rails、2番目から検索し始めるので8
p a.index("u", 1) #1

a1 = [1,2,3]
a2 = [4,2,3]
p a1 | a2 #和集合で[1,2,3,4]

hash = {price: 100, order_code: 200, order_date: "2018/09/20", tax: 0.8}
p hash.values_at(:price, :tax) #[100,0.8]
