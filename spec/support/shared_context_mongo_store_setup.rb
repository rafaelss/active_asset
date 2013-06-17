shared_context "mongo #store setup" do
  let(:image) { File.open("spec/fixtures/image.gif", "r") }

  before do
    grid.
      should_receive(:put).
      with(image).
      and_return(double("object_id", :to_s => "1234"))
  end
end
