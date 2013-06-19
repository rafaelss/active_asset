shared_examples_for "a savable active record model with files" do
  let(:storage) { double("Storage") }
  let(:storage_class) { double("StorageClass", :new => storage) }

  it "saves the file uid in the respective column" do
    stub_const("ActiveAsset::Storage::Mongo", storage_class)
    storage.
      should_receive(:store).
      with(image, options).
      and_return("51bf98def4e3524da6000001")

    model.send("#{mount}=", image)
    model.save

    expect(model.send("#{mount}_uid")).to eq("51bf98def4e3524da6000001")
  end
end
