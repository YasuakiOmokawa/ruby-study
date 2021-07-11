require "active_record"
require "benchmark/ips"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database:  ":memory:")
ActiveRecord::Base.connection.create_table :users do |t|
  t.text :name
end

class User < ActiveRecord::Base
  # This is the current implementation from ActiveRecord::Core
  def hash
    if id
      self.class.hash ^ id.hash
    else
      super
    end
  end
end
class UserFastHash < ActiveRecord::Base
  self.table_name = "users"
  def hash
    if i = id
      self.class.hash ^ i.hash
    else
      super
    end
  end
end

1_000.times { |i| User.create(name: "test #{i}") }
slow_users = User.take(1000)
fast_users = UserFastHash.take(1000)

Benchmark.ips do |x|
  x.report("slowhash") {
    hash = {}
    slow_users.each { |u| hash[u] = 1 }
  }
  x.report("fasthash") {
    hash = {}
    fast_users.each { |u| hash[u] = 1 }
  }
  x.compare!
end