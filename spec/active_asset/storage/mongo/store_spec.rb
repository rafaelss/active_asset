require "spec_helper"
require "active_asset/storage/mongo"

describe ActiveAsset::Storage::Mongo, "#store" do
  context "with default options" do
    include_context "default mongo connection"
    include_context "mongo #store setup"

    it "stores the file in default grid" do
      uid = subject.store(image)
      expect(uid).to eq("1234")
    end
  end

  context "with custom options" do
    include_context "custom mongo connection"
    include_context "mongo #store setup"

    it "stores the file in custom grid" do
      uid = subject.store(image, :host => "123.456.789.012", :port => 71072, :database => "images", :grid => "mysite")
      expect(uid).to eq("1234")
    end
  end
end
