#block, and closure
def func y
  y + yield
end
x = 2
p func(1){x+=2} #5

# yield with args
def func2 a,b
  a + yield(b,3)
end
p func2(1,3) {|x,y| x+y} #7
p func2(1,3) {|x,y| x*y} #10

# proc is objected block
proc = Proc.new{|x| p x}
proc.call(1) #1
proc.call(2) #2

def count(start)
  Proc.new{|up| start += up}
end
counter = count(0) #0
counter.call(1) #1
counter.call(1) #2
