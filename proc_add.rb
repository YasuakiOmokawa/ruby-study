val = 100

def method(val)
  yield(15 + val)
end

_proc = Proc.new{|arg| val + arg }

p method(val, &_proc)
