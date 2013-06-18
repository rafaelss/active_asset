shared_context "mongo #store setup" do
  let(:image) { File.open("spec/fixtures/image.gif", "r") }

  before do
    grid.
      should_receive(:put).
      with(image).
      and_return(double("objectid", :to_s => "51bf98def4e3524da6000001"))
  end
end
