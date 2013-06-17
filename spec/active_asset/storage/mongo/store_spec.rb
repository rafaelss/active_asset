require "spec_helper"
require "active_asset/storage/mongo"

describe ActiveAsset::Storage::Mongo, "#store" do
  include_context "default mongo connection"

  it "stores the file in default grid" do
    image = File.open("test/fixtures/image.gif", "r")

    grid.
      should_receive(:put).
      with(image).
      and_return(double("object_id", :to_s => "1234"))

    uid = subject.store(image)
    expect(uid).to eq("1234")
  end
end
