shared_context "custom mongo connection" do
  let(:connection_class) { Class.new }
  let(:connection) { double("connection") }
  let(:db) { double("db") }
  let(:grid_class) { Class.new }
  let(:grid) { double("grid") }

  before do
    stub_const("Mongo::Connection", connection_class)

    connection_class.
      should_receive(:new).
      with("123.456.789.012", 71072).
      and_return(connection)

    connection.
      should_receive(:db).
      with("images").
      and_return(db)

    stub_const("Mongo::Grid", grid_class)

    grid_class.
      should_receive(:new).
      with(db, "mysite").
      and_return(grid)
  end
end
