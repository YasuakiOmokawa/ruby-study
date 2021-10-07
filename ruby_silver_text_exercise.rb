# https://www.amazon.co.jp/%EF%BC%BB%E6%94%B9%E8%A8%822%E7%89%88%EF%BC%BDRuby%E6%8A%80%E8%A1%93%E8%80%85%E8%AA%8D%E5%AE%9A%E8%A9%A6%E9%A8%93%E5%90%88%E6%A0%BC%E6%95%99%E6%9C%AC%EF%BC%88Silver-Gold%E5%AF%BE%E5%BF%9C%EF%BC%89Ruby%E5%85%AC%E5%BC%8F%E8%B3%87%E6%A0%BC%E6%95%99%E7%A7%91%E6%9B%B8-%E7%89%A7-%E4%BF%8A%E7%94%B7-ebook/dp/B0756VF9Y3/ref=tmm_kin_swatch_0?_encoding=UTF8&qid=1633346406&sr=8-1

#1
1,2,4

#2
x = 0
def hoge
  (1..5).each do |i|
    x += 1
  end
  puts x
end
hoge # exception

#3
# Error.
# Ensure.
begin
  puts 1+'2'
rescue
  puts 'Error'
rescue TypeError
  puts 'Type Error.'
ensure
  puts 'Ensure.'
end

#4
puts 090 # error

#5
x = 10
y = x < 10 ? "A" : "B"
puts y #B

#6
MAX=10
print MAX #10
MAX=100 #warning
print MAX #100

#7
def foo(*a)
  p a
end
foo(1,2,3) #[1,2,3]
