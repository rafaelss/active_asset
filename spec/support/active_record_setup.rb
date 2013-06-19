require "active_record"
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Base.connection.create_table(:users, :force => true) do |t|
  t.string :name
  t.string :avatar_uid
end

ActiveRecord::Base.connection.create_table(:shops, :force => true) do |t|
  t.string :name
  t.string :logo_uid
end
