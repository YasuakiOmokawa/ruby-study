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
