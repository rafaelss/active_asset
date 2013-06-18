shared_context "objectid" do
  let(:objectid_class) { Class.new }
  let(:objectid) { double("objectid", :to_s => "51bf98def4e3524da6000001") }

  before do
    stub_const("BSON::ObjectId", objectid_class)
    objectid_class.
      should_receive(:from_string).
      with("51bf98def4e3524da6000001").
      and_return(objectid)
  end
end
