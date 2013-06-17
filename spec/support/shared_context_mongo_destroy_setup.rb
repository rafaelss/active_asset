shared_context "mongo #destroy setup" do
  before do
    grid.
      should_receive(:delete).
      with("1234").
      and_return({ "err" => nil })
  end
end
