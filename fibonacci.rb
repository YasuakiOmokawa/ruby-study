fib = Fiber.new do
  a = 0; b = 1
  loop do
    a, b = b, a + b
    Fiber.yield a
  end
end
def fib.each
  loop do
    yield self.resume
  end
end
fib.each do |i|
  break if 100 > i
  puts i
end
