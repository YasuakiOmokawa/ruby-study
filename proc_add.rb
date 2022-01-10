val = 100

def method(val)
  yield(15 + val)
end

_proc = Proc.new{|arg| val + arg }

p _proc.to_proc
p method(val, &_proc.to_proc)
