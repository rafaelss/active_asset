shared_examples_for "a destroyable active record model with files" do
  let(:storage) { double("Storage") }
  let(:storage_class) { double("StorageClass", :new => storage) }

  it "destroys the file in mongo" do
    stub_const("ActiveAsset::Storage::Mongo", storage_class)
    storage.
      should_receive(:destroy).
      with("51bf98def4e3524da6000001", options).
      and_return("err" => nil)

    model.destroy
    expect(model.send("#{mount}_uid")).to eq(nil)
  end
end
