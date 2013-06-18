shared_context "mongo #retrieve setup" do
  include_context "objectid"

  let(:image) { File.open("spec/fixtures/image.gif", "r") }

  before do
    grid.
      should_receive(:get).
      with(objectid).
      and_return(image)
  end
end
