require "spec_helper"
require "active_asset/storage/mongo"

describe ActiveAsset::Storage::Mongo, "#retrieve" do
  include_context "default mongo connection"

  it "retrieves the file from default grid" do
    image = File.open("test/fixtures/image.gif", "r")

    grid.
      should_receive(:get).
      with("1234").
      and_return(image)

    image = subject.retrieve("1234")
    expect(image).to eq(image)
  end
end
