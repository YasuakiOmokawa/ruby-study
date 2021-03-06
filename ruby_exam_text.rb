# ruby_exam_text

palindrome = 'Was it a car or a cat I saw?'
p palindrome #=&gt; ?
palindrome.reverse
p palindrome #=&gt; ?
emordnilap = palindrome.reverse
p emordnilap.reverse #=&gt; ?
p emordnilap.reverse! #=&gt; ?
p emordnilap #=&gt; ?

# assoc
ary = [[1,2], [3,4], [5,6]]
p ary.assoc 2 # -> nil
p ary.assoc 1 # -> [1,2]

# bsearch
def square(x)
  x * x
end
def root(y)
  (0..Float::INFINITY).bsearch do |x|
    y < square(x)
  end
end
p root(2) # => 1.4142135623730951

# clone, dup
ary = ['string']
p ary             #=> ["string"]
copy = ary.clone
p copy            #=> ["string"]
ary[0][0...3] = ''
p ary             #=> ["ing"]
p copy            #=> ["ing"]
p ary.object_id
p copy.object_id

# each_with_object
arr = [1,2,3]
res = arr.each_with_object([1,2,3]) do |item, memo|
  memo << item * 2
end
p res # => [1,2,3,2,4,6]

# cycle
arr = %i[a b c]
arr.cycle(3) { |x| puts x } # => a,b,c,a,b,c,a,b,c
switch = %i[on off].cycle
switch.next # => on
switch.next # => off
switch.next # => on
# 累乗計算
arr2 = [*1..10].concat([*2..9].reverse)
arr2.cycle do |num|
  puts 'w' * (num ** 2)
end

# reject
a = [0, 1, 2, 3, 4, 5]
e = a.reject!
e.each{|i| i % 2 == 0}
p a                    #=> [1, 3, 5]  もとの配列から削除されていることに注意。

# Array#dig
a = [{foo: :bar}, {hoge: :fuga}]
a.dig(0, :foo) # => :bar
a.dig(1, :hoge) # => :fuga

# first
ary = [0, 1, 2]
p ary.first

# keep_if
%w(a b c d e).keep_if { |w| w =~ /[aiueo]/ } #=> ['a', 'e']

# minmax
a = %w(albatross dog horse ho)
a.minmax                                 #=> ["albatross", "horse"]
a.minmax{|a,b| a.length <=> b.length }   #=> ["dog", "albatross"]

# none
%w{ant bear cat}.none? {|word| word.length == 5}  # => true
%w{ant bear cat}.none? {|word| word.length >= 4}  # => false
%w{ant bear cat}.none?(/d/)                       # => true

# permutation 順列の作成
a = [1, 2, 3]
a.permutation.to_a     #=> [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
a.permutation(1).to_a  #=> [[1],[2],[3]]
a.permutation(2).to_a  #=> [[1,2],[1,3],[2,1],[2,3],[3,1],[3,2]]
a.permutation(3).to_a  #=> [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]

# repeated_combination(n)
a = [1, 2, 3]
a.repeated_combination(1).to_a  #=> [[1], [2], [3]]
a.repeated_combination(2).to_a  #=> [[1,1],[1,2],[1,3],[2,2],[2,3],[3,3]]
a.repeated_combination(3).to_a  #=> [[1,1,1],[1,1,2],[1,1,3],[1,2,2],[1,2,3],
                                #    [1,3,3],[2,2,2],[2,2,3],[2,3,3],[3,3,3]]
a.repeated_combination(4).to_a  #=> [[1,1,1,1],[1,1,1,2],[1,1,1,3],[1,1,2,2],[1,1,2,3],
                                #    [1,1,3,3],[1,2,2,2],[1,2,2,3],[1,2,3,3],[1,3,3,3],
                                #    [2,2,2,2],[2,2,2,3],[2,2,3,3],[2,3,3,3],[3,3,3,3]]
a.repeated_combination(0).to_a  #=> [[]] # one combination of length 0

# sample
a = (1..10).to_a
p a.sample
p a.sample
p a.sample(3)
p a               #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# ランダムにしていくつかの配列に分割
a = (1..10).to_a.shuffle!
i = a.size/3.floor
i.times.each { p a.shift i }

# 範囲選択
# http://www.minituku.net/drills/775230600.html
# https://docs.ruby-lang.org/ja/latest/class/Range.html
(1...5) # 1 < x < 5
p (1...5).to_a.map { |i| i * 10} # [10,20,30,40]
p [1, 2, 3, 4].zip([10, 10, 10, 10]) # [[1,10],[2,20],[3,30],[4,40]]
p (10..40).to_a # [10,11,12,13,14,15,..35,36,37,38,39,40]
p [1, 2, 3, 4].select{|i| i * 10} # [1,2,3,4]

# エラーとなるコードについて
# https://docs.ruby-lang.org/ja/latest/class/Range.html
# ng argument error
def foo(x)
  puts x
end
foo()

# ok
n = 10
n.times do |i|
  puts i + n
end

# ng argument error
def bar
  puts n
end
n = 10
bar(n)

# ng undefined local value
10.times do |i|
  n = i
  puts n
end
puts n

# 範囲の値について
# https://docs.ruby-lang.org/ja/latest/class/Range.html
s = 0xBacFace # 195885774
s += 1 # 195885775
puts s # not error

# 文字列クラス
# https://docs.ruby-lang.org/ja/latest/class/Range.html
p "abcdefg"[2..3] #cd
p ['a', 'b', 'c','d','e'][0..2].join # abc
p 'abcdefg' - 'ab' - 'fg' # undefined - method error
p 'abcdefg'[2, 3] #cde

# 正常に実行が完了するコード
# https://docs.ruby-lang.org/ja/latest/class/Range.html
10.+('10') # string can't be coerced into Integer
1..10.to_s # invalid range error
10.*(0xFace) # ok
Time.now.strftime(1999,12,11) # not formatted error

# https://gist.github.com/sean2121/945035ef2341f0c39bf40762cd8531e0#%E5%95%8F%E9%A1%8C2-%E4%BB%A5%E4%B8%8B%E3%81%AE%E3%82%B3%E3%83%BC%E3%83%89%E3%82%92%E5%AE%9F%E8%A1%8C%E3%81%97%E3%81%9F%E5%87%BA%E5%8A%9B%E3%81%A8%E3%81%97%E3%81%A6%E6%AD%A3%E3%81%97%E3%81%84%E3%82%82%E3%81%AE%E3%82%921%E3%81%A4%E9%81%B8%E6%8A%9E%E3%81%97%E3%81%A6%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84
def foo (a, *b)
  p a
end
foo(1,2,3,4) # 1

# https://gist.github.com/sean2121/945035ef2341f0c39bf40762cd8531e0#%E5%95%8F%E9%A1%8C3-%E4%BB%A5%E4%B8%8B%E3%81%AE%E3%82%B3%E3%83%BC%E3%83%89%E3%82%92%E5%AE%9F%E8%A1%8C%E3%81%97%E3%81%9F%E6%99%82%E3%81%AE%E5%87%BA%E5%8A%9B%E3%81%A8%E3%81%97%E3%81%A6%E6%AD%A3%E3%81%97%E3%81%84%E3%82%82%E3%81%AE%E3%82%921%E3%81%A4%E9%81%B8%E6%8A%9E%E3%81%97%E3%81%A6%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84
puts({"members" => 193, "year" => 2014}.size) # 2

# q4
t = Time.now + (60*60*24)
p t # 1 days after

# q6
(5..8).each_with_index do |val,i|
puts "#{i} #{val}" # 0..3, 5..8
end

# q7
p 100.downto(90).select{|x| x%2==0} # [100,98,..,90]

# q8
# same result
p [1,1,2,3,5,8].collect {|x| x*2}
p [1,1,2,3,5,8].map {|x| x*2}

# q9
puts "Ruby on Rails".delete("Rails") # 'uby on '
puts "Ruby on Rails".delete("uos") # 'Rby n Rail'

# q10
# below has no error at all
doc = <<-EOF
 The quick brown fox
 jumps over the lazy dog
      EOF
doc2 = <<EOF
 The quick brown fox
 jumps over the lazy dog
EOF

# q11
h = {1=>2, 3=>4}
h.clear
p h   #=>{}

ary = [1, 2]
ary.clear
p ary     #=>[]

# q12
a = [1,2,3,4,5]
p a[0..2]    #=>[1,2,3]
p a.slice(0,3)    #=>[1,2,3]

# q13
str = "RubyAssociation".chomp # 'RubyAssociation'

# q14
str = "RubyAssociation\r\n".chop # 'RubyAssociation'

# q15
File.open("foo.txt","r") do |io|
  puts io.gets
  puts io.read
  io.rewind
  p 'move first pointer'
  p lines = io.readlines(chomp: true) # ポインタが先頭に戻ったので全行読み込んで配列に格納
end

# q16
mozart = ["Symphony","Piano Concerto", "Violin Concerto","Horn Concerto","Violin Sonata"]
listend = ["Symphony","Violin Concerto","Horn Concerto"]
p mozart - listend # ["Piano Conerto","Violin Sonata"]

# q17
odd = [1,3,5]
even = [2,4,6]
num = odd + even
p num.sort # [1,2,3,4,5,6]

# q19
Greeting = "Hello Ruby"
Greeting = "Hi Ruby"
p Greeting # warning and puts 'Hi Ruby'

# q20
p File.join("ruby", "exam","silver") # ruby/exam/silver

# q21
class Surface
  attr_reader :s
  def initialize(x,y)
   @s = x * y
  end
end

class Volume < Surface
  attr_reader :v
  def initialize(x,y,z)
    super(x,y)
   @v = x * y * z
  end
end

a = Volume.new(2,5,5)
puts "#{a.v},#{a.s}" # 50,10

#q21
string = "test code"
string.slice(0,4)
p string #test code

#q22
string = "test code"
string.slice(0,4)
p string # test code

#q23
puts "ruby".encoding.name #error

#q24
cc = {"nz"=>"New Zealand", "ru"=>"Russia", "ar"=>"Argentina"}
cc.contain?('nz') #error

#q25
p "Hello there".class # String
p String.superclass # Object

class Foo; end
class Bar < Foo; end
p Foo.superclass #Object
p Bar.superclass #Foo

#q26
s = "To be or not to be, that is the question."
hash = Hash.new(0)
s.scan(/\w+/) {|i| hash[i] += 1}
p hash["be"] #=>2

#28
# error
s = "foo"
begin
  s[4] = ?b
rescue IndexError
  puts "error"
end

#29
ary = []
ary << 1 && false
true || ary << 2
false && ary << 3
false || ary << 4
p ary # [1,4]

#30
p "foo" * 2 **2 #foofoofoofoo

#31
foo = [1,2,3]
bar = foo
baz = foo.dup

bar[3] = 4
p foo #[1,2,3,4]
p bar #[1,2,3,4]
p baz #[1,2,3]

#33
str = "a,b,c,d"
p str.split(/,/, 2) #['a', 'b,c,d']

#34
class Object
  def greeting
    print "How are you?\n"
  end
end
[1,2].greeting #'How are you?'

#37
File.open("foo.txt") do |io|
  io.write(Time.now.strftime("%Y/%m/%d"))
end # not opened for writing (IOError)

#39
puts "0123456789".delete("0-58-") #679

#40
p "100,200,300,400,500".split(',').join('\n')

#41
a = "foo"
b = "foo"

puts a.eql?(b) #true
puts a.equal?(b) #false

#42
numbers = [3,89,40,39,29,10,50,59,69]
num = numbers.inject do |i,j|
  i > j ? i : j
end
p num #89

#43
p String.instance_methods.grep(/strip/) # [methods includes 'strip' character]

#44
capital ={:Sweden =>"Stockholm", :Norway=>"Oslo", :Finland=>"Helsinki1"}
capital = {Sweden: "Stockholm", Norway: "Oslo", Finland: "Helsinki2"}
capital = {"Sweden" = "Stockholm", "Norway" = "Oslo", "Finland" = "Helsinki3"} # error
capital = Hash[:Sweden,  "Stockholm", :Norway ,"Oslo", :Finland, "Helsinki4"]

#45
require 'uri'
uri = URI::HTTP.build({host:'www.ruby.or.jp', path:'/ja/certification/examination/'})
puts uri # http://www.ruby.or.jp/ja/certification/examination/

#46
class Foo
  @@num = 0
  def self.count
    @@num += 1
  end
end

class Bar < Foo
end

puts Foo.count #1
puts Bar.count #2

#47
# 'Hello'
unless false || nil
  print "Hello\n"
end

#48
numbers = (1..20).to_a
p numbers.detect{|x| x % 5 == 0} #5

#49
# non ascii character detected : ルビーアソシエーション non ascii character detected : るびー
class NonasciiError < StandardError
end

File.open("sample.txt") do |io|
  io.each_line do |str|
    begin
      raise(NonasciiError, "non ascii character detected") unless str.ascii_only?
    rescue => ex
      puts "#{ex.message} : #{str}"
    end
  end
end
