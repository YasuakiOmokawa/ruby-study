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
