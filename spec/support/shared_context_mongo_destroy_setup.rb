shared_context "mongo #destroy setup" do
  include_context "objectid"

  before do
    grid.
      should_receive(:delete).
      with(objectid).
      and_return({ "err" => nil })
  end
end
