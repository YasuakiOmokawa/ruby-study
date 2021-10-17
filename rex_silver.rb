begin
  raise StandardError.new
rescue => e
  puts e.class
end
#StandardError

raise ['message'] # type error

h = {a: 100}
h.clear
p h #{}

open('test.txt', 'r+') do |f|
  data = f.read.upcase
  f.rewind
  f.puts data
end
=begin
AA 1
BB 2
=end
