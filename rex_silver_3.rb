puts 0b2 #error
'0x90'.hex #16進数で9*16=144
puts '90' #90
'80'.oct #8進数で1*16 + 2*8 = 120 となりそうだが、変換対象が80は8進数ではないため空文字とみなして0

$val = 0 #$が先頭にあるとグローバル変数
class Count
  def self.up
    $val = $val + 1
    $val == 3 ? true : false
  end
end
[*1..10].any? do # trueな値のみなのでtrue
  Count.up #4回目でfalse
end
p $val #Count.upが3回だけ実施されるので3

hoge = "a".to_h #文字列をto_hできない
puts hoge.class

h = {a: 100, b: 200}
h.clear
p h #clearしたら空配列に破壊的変更

hoge = "a".to_a #stringはto_aない, error
puts hoge.class

def hoge(step = 1)
  current = 0
  Proc.new {
    current += step
  }
end
p1 = hoge
p2 = hoge(2)
p1.call
p1.call
p1.call
p2.call
p2.call
p p2.call #インスタンス間で状態を共有する作りでもないので、p2で作成されたProcは独立している。callが3回、stepが2で定義されているので１回ごとに2カウントされる。よって6

a1 = "abc"
a2 = 'abc'
print a1.eql? a2 #値も型も同じ true
print a1 == a2 #値が同じ true

p "Hello" % 5 #置き換える書式文字列がないため'Hello'

str = "Liberty Fish   \r\n"
str.chop
p str #chopは非破壊メソッドなので'Liberty Fish   \r\n'

10.times{|d| print d == 3..d == 5 ? "T" : "F" } # d == 3..d == 5 は、5 == 3..5 == 5、つまり、範囲式における条件式。nanode, 3,4,5のときにtrueになる
#FFFTTTFFFF

arr = Array.new(3){"a"}
arr.first.upcase!
p arr
arr = Array(3){'a'} #[3]

def hoge
  x = 10
  Y = x < 10 ? "C" : "D" #定数を動的に宣言できない。syntax error
  puts Y
end
hoge

hoge = *"a"
puts hoge.class #Array

str = "abcdefghijk"
p str[2,4] #cdef

(1..10).each
.reverse_each
.each do |i|
  puts i
end

a = [1,2,3,4]
p a.slice(2,1) #[3]

s = <<'EOF'
Hello,
Ruby
'EOF'
EOF
p s #Hello,\nRuby\nEOF\n

s = ["one", "two", "three"]
s.shift
s.shift
s.unshift
s.push "four"
p s #[three, four]

h = {a: 100, b: 200}
h.delete(:a)
p h #{:b=>200}

str = "Liberty Fish   \r\n"
str.strip
p str #stripは非破壊メソッドなので"Liberty Fish   \r\n"

a, b = 0
c, a = 1
a, d = 1, 2
b, c = 3
p [a, b, c, d] #[1,3,nil,2]
a,b,c,d = 0
p [a, b, c, d] #[0,nil,nil,nil]

puts 080 #invalid octal digit
puts '10'.oct #8
puts'110'.to_i(2) #6

array = Array.new(3){"Apple"}
array[0].upcase!
p array #[AP,Ap,Ap]

str = <<EOS
よりニッチに。よりユニークに。
  IT市場はもちろん、ヘルスケア・医療・介護など
    次世代市場における企業や生活者のユーザビリティを向上させる
      サービス、ソフトウェアを開発しています。
    #{1 + 1}
EOS
puts str #EOSはダブルクォートと同じ。式展開は行われる。スペースも改行も正しく表記される。

chars = "I love apple, banana and grape"
5.times do
  chars = chars.sub("a", "@") # 先頭から検索し、aを@に置換
end
p chars #"I love @pple, b@n@n@ @nd grape"

CONST = "REx"
def foo
  CONST
end
puts foo #REx

a1 = [1,2,3]
a2 = [4,2,3]
p a1 && a2 #[4,2,3]

a1 = "abc"
a2 = 'abc'
print a1.equal? a2 #false
print a1 == a2 #true

hash = Hash.new {|h, k| raise(KeyError, "Key #{k} does not exist in hash #{h}") }
XXXX

a = [1, 2, 3, 4, 5]
a.each { |n| puts n }

(x, y), z = 1, 2, 3
p z #2

("a".."d").each_with_index do |v, i|
  puts "#{i} / #{v}"
end
=begin
0 / a
1 / b
2 / c
3 / d
=end

p "Apple-Banana-Lemon".split /(-)/ #括弧の-も分割される。["Apple", "-", "Banana", "-", "Lemon"]

a1 = [1,2,3]
a2 = [4,2,3]
p a1 || a2 #[1,2,3]

v1 = false || 1 + 1 == 1.to_i # false代入でfalseとなり、1+1 == 1.to_iが実行され、falseとなる
puts v1

klass = Class.new
hash = {klass => 100}
puts hash[klass] #100

klass = Class.new
hash = {}
hash.store(klass, 100)
puts hash[klass] #100

klass = Class.new
hash = Hash[klass, 100]
puts hash[klass] #100

count = 0
begin
  1 / count
rescue NameError
  count += 1
  retry
rescue NoMethodError
  count += 2
  retry
rescue ZeroDivisionError
  count += 3
  retry
else
  puts 4
ensure
  puts "count: #{count}"
end
# 4
# count: 3
# zerodivisionerrorでcountが3になり、retryでrescueが実行されずelseが実行される。最後にensureが実行され、count: 3

str = "aaabbcccddd"
p str.scan("c") #scanは、マッチした文字列を含む配列を返却。[c,c,c]

a = [-1, 2, 3, 4, 5]
b = (4..6).to_a
puts a.inject(:+) + b.inject(:+) #9+15 = 24
puts (a | b).inject(:-).abs + (a & b).inject(:+).abs #21 + 9 = 30
puts (a | b).inject(:*) + b.inject(0) { |x, y| x + y ** 3 } #-1 * 2*3*4*5*6 = -72 + 4**3 + 5**3 + 6**3 > 30
????

