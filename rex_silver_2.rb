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

str = "abcdefghijk"
p str[2...4] #2~3index目を取得。cd

str = "1;2;3;4"
p str.split(";") #[1,2,3,4]

begin
  1 / 0
rescue
  raise # ここで発生する例外はzerodivisionerror
end

h = {a: 100, b: 100}
puts h.invert #キーが重複するときは最後の値が設定されるため、{100=>:b}

a = [1,2,3,4]
p a.slice(2,1) #2index目から1文字なので[3]

a1 = "abc"
a2 = 'abc'
print a1.equal? a2 #false オブジェクトが不一致
print a1.eql? a2 #true 値が一致

arr = %i[apple banana orange].reverse
arr.each do |i|
  puts i
end
=begin
reverseしたものを変数に格納しているため,
orange
banana
apple
の順番
=end

h = {a: 100, b: 200}
h.delete(:a)
p h #{:b=>200} deleteは破壊的メソッド

s = <<-EOF
      Hello,
      Ruby
      EOF
p s #' Hello,\n Ruby\n'

def hoge
  x = 0
  (1...5).each do |i|
    x += 1
  end
  x
end
puts hoge #4回しか加算されないので4

a = "Ruby"
b = " on Rails"
a.append b
a.reverse
p a.index("R", 1) #stringにappendはない。エラー

puts 080 #8進数に8はない。エラー
puts 070 #8進数として解釈される

io = File.open('list.txt')
while not io.eof?
  io.readlines
  io.seek(0, IO::SEEK_CUR)
  p io.readlines
end #readlinesで最後のlineまできて、現在位置から0バイト移動し、ふたたびreadlinesする。最後のlineなので、[]

hash = {price: 100, order_code: 200, order_date: "2018/09/20", tax: 0.8}
p hash.values_at(:price, :tax)

x = 1
y = 1.0
print x == y #値が等しい true
print x.eql? y #値は等しいが型が異なる false
print x.equal? y #object_idが異なる false
print x.equal?(1) #定数Integerはobject_idが同じ true

a1 = "abc"
a2 = 'abc'
print a1.equal? a2 #object_idがことなる false
print a1 == a2 #値が同じ true

class Foo
  @@foo = 0

  def foo
    @@foo
  end

  def foo=(value)
    @@foo = value
  end
end
foo1 = Foo.new
foo1.foo += 1
foo2 = Foo.new
foo2.foo += 2
puts "#{foo1.foo}/#{foo2.foo}" #クラス変数はインスタンス間で共有されるため、3/3

a = [1, 2, 3, 4, 5]
b = [2, 4, 6]
p (a - b).map(&:next) #[2,4,6]

str = "abcdefgh"
puts str[4..6] == str[-4...7]

arr = [
  "a".to_i(36), #36進数のa、10
  "070".to_i(0), #8進数の070, 56
  nil.to_i, #nilにto_iすると0
  "0b0001".to_i #先頭に数値のない文字列にto_iしたので0
]
p arr
'1a'.to_i #先頭に数値のある文字列にto_iしたので数値の1だけが出力される

a1 = [1,2,3]
a2 = [4,2,3]
p a1 || a2 #a1がtrueなので[1,2,3]

hash = { a: 100, b: 200, c: 300, a: 150, c: 250 }
p hash #おなじkeyだと後続の値が設定されるので{:a=>150, :b=>200, :c=>250}

x, y, z = 1, [2, 3]
p z #[2,3]は括られているのでyに入る。zはnil

puts '7'.binary #no method erro
puts '80' #80
puts 0xFF #(15*16) + 15 =255
puts 7.to_s(3) #3進数で7を表現すると21

puts "Ruby-Examination"[5] #文字列のindex番目を指すのでE

