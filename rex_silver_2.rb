s = <<'EOF'
Hello,
Ruby
EOF
'EOF'
p s #Hello,\nRuby\n

require 'date'
d = Date.new(2015, 1, 5)
puts d.strftime('%x') #01/05/15 %xは%D(%m%d%y)と同じ

begin
  raise StandardError.new
rescue => e
  puts e.class
end
# StandardError

p "Hello%d" % 5 #Hello5

hoge = 'a'.to_h #error
puts hoge.class

require 'date'
Date.today.to_s == Date.today.strftime('%Y-%m-%d') #true

def foo
  self + 2
end
p 1.foo #fooはIntegerに定義されてないのでsyntaxerror

arr = [1,2].product([3,4]).transpose
p arr # [[1,3],[1,4],[2,3],[2,4]]の行列変換なので、[[1,1,2,2],[3,4,3,4]]

str = "1;2:3;4"
p str.split(/;|:/) #[1,2,3,4]

a, = (1..5).partition(&:odd?) #partitionでブロック式のtrueとfalseの配列が返される。aはtrueのみ代入されるので[1,3,5]
p a

hoge = "a".to_a #stringをarrayには変換できない、エラー
puts hoge.class

a = [1, 2, 3, 4]
p a[1..2] #配列のindex1,2を抽出する。[2,3]

p [1,2,3,4].map do |e| e * e end # {}でないためmapとの結びつきよりもenumratorに配列を渡したことになる。<Enum [1,2,3,4]>

str = "Liberty Fish   \r\n"
str.strip!
p str #strip!で両端の空白文字を削除する破壊的変更。空白文字には\r\nもふくまれる。'Liberty Fish'

(10..15).to_a.map.with_index(1) do |elem, i|
  puts i
end
=begin
with_index(1)なので、indexは1から始まる。
1
2
3
4
5
6
=end

arr = (1..30).to_a
container = []
arr.each_cons(7) do |i|
  container << i
end
p container.length #each_cons(7)は7を1ブロックにして1つずつ値をずらしながらループする。30-7+ずらし分の1=24なので、24つの配列ができる

a1 = [1,2,3]
a2 = [4,2,3]
p a1 - a2 #2,3が取り除かれるので1

h = Hash[] #からハッシュの作成
h.fetch('key') # キーに紐づくデータの取得

v1 = 1 - 1 == 0
v2 = v1 || raise RuntimeError #raiseはシンタックスエラー
puts v2 && false

str = "Liberty Fish   \r\n"
str.chop
p str #末尾の改行コード\r\nを削除するので"Liberty Fish "となりそうだが、chopは非破壊メソッドなので改行コードが残る

File.open('testfile.txt', 'a') do |f|
  f.write("recode 1\n")
  f.seek(0, IO::SEEK_SET)
  f.write("recode 2\n")
end

def foo(n)
  n ** n
end
puts foo(2) * 2 #2*2*2=8

