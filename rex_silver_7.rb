def hoge(n)
  unless n == 3
    ret = "hello"
  end
  if n == 5
    ret = "world"
  end
  ret
end
str = ''
str.concat hoge(4)
str.concat hoge(5)
puts str #helloworld

puts Time.now + 3600 #+1h

io = File.open('list.txt')
while not io.eof?
  io.readlines
  io.seek(0, IO::SEEK_CUR)
  p io.readlines
end

klass = Class.new
hash = {klass => 100}
puts hash[klass]

klass = Class.new
hash = {klass: 100} #symbol
puts hash[klass]

klass = Class.new
hash = Hash[klass, 100]
puts hash[klass]