shared_context "default mongo connection" do
  let(:connection_class) { Class.new }
  let(:connection) { double("connection") }
  let(:db) { double("db") }
  let(:grid_class) { Class.new }
  let(:grid) { double("grid") }

  before do
    stub_const("Mongo::Connection", connection_class)

    connection_class.
      should_receive(:new).
      with("localhost", 27017).
      and_return(connection)

    connection.
      should_receive(:db).
      with("assets").
      and_return(db)

    stub_const("Mongo::Grid", grid_class)

    grid_class.
      should_receive(:new).
      with(db).
      and_return(grid)
  end
end
