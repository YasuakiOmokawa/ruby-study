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
