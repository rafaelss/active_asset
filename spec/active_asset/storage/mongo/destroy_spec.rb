require "spec_helper"
require "active_asset/storage/mongo"

describe ActiveAsset::Storage::Mongo, "#destroy" do
  include_context "default mongo connection"

  it "destroy the file in default grid" do
    grid.
      should_receive(:delete).
      with("1234").
      and_return({})

    hash = subject.destroy("1234")
    expect(hash).to eq(hash)
  end
end
