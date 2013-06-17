shared_context "mongo #retrieve setup" do
  let(:image) { File.open("spec/fixtures/image.gif", "r") }

  before do
    grid.
      should_receive(:get).
      with("1234").
      and_return(image)
  end
end
