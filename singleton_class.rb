# singleton class is a specialized class attached in instance
class Foo
  def initialize(a)
    @a = a
  end
end
foo1 = Foo.new(1)
foo2 = Foo.new(1)
def foo1.methodB
  'B'
end
p foo1.methodB #B
p foo2.methodB #error

# include module into instance
require './bar'
foo1 = Foo.new(1)
foo2 = Foo.new(1)
foo1.extend(Bar)
foo1.methodA #A
foo2.methodA #error

# クラスに定義したselfはクラス自身
# メソッド内のselfはメソッドを呼び出したオブジェクト（レシーバ）を指す
class C
  p self
  def method1
    self
  end
end
c1 = C.new
p c1.method1 == c1 #true

# メソッドがネストした場合、メソッドの定義先はクラス
# ネストしたメソッドは外側のメソッドが実行されるまで定義されない
class C2
  def method1
    def method2; end
  end
end
C2.instance_methods(false) #[:method1]
C2.new.method1
C2.instance_methods(false) #[:method1, :method2]
