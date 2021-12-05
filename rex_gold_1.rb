# rex gold 1

p (1..10).lazy.map{|num|
  num * 2
}.take(3).inject(0, &:+) #12

p (1..10).map{|num|
  num * 2
}.take(3).inject(0, &:+) #12

module M
  def class_m
    "class_m"
  end
end

class C
  include M
end

p C.methods.include? :class_m #false

class C2
  class << self
    include M
  end
end
p C2.methods.include? :class_m #true
p C2.singleton_methods(false).include? :class_m #false
p C.new.methods.include? :class_m #true
# moduleをincludeすると、defはインスタンスメソッドなのでクラスのmethodsでは応答しない。
# newするか、特異メソッドとしてincludeしてやれば応答できる。

class A
  HOGE = 'A'
end
module B
  HOGE ='B'
  class C < A
    def hoge
      puts HOGE
    end
  end
end
B::C.new.hoge #B

class A
  def hoge
    'メソッド探索はスーパークラスのみ実施する'
  end
end
module B
  def hoge
    'レキシカルスコープ'
  end
  class C < A
    def fuga
      hoge
    end
  end
end
p /メソッド探索はスーパークラスのみ実施する/.match?(B::C.new.hoge)

class A
  def hoge
    fuga
  end
end
class B < A
  def fuga
    'スーパークラスでサブクラスのメソッドは問題なく呼べる'
  end
end
p /スーパークラスでサブクラスのメソッドは問題なく呼べる/.match? B.new.hoge

class A
  HOGE = 'A'
  def hoge
    HOGE
  end
end
class B < A
  HOGE = 'B'
end
p /A/.match? B.new.hoge

class A2
  def hoge
    HOGE
  end
end
class B < A2
  HOGE = 'B'
end
p B.new.hoge #uninitialized constant A2::HOGE

module D
  module E
    B.class_eval do
      def fuga
        puts self
        puts HOGE
      end
    end
  end
end
p B.new.fuga

class A
  def hoge
    B::HOGE
  end
end
class B < A
  HOGE = 'B'
end
p B.new.hoge #B

class A
  HOGE = "hoge"
end
class B < A
  def hoge
    puts A::HOGE #hoge
    puts B::HOGE #error
    puts HOGE #error
  end
end
p B.new.hoge
