require "spec_helper"
require "active_asset/storage/mongo"

describe ActiveAsset::Storage::Mongo, "#retrieve" do
  context "with default options" do
    include_context "default mongo connection"
    include_context "mongo #retrieve setup"

    it "retrieves the file from default grid" do
      image = subject.retrieve("1234")
      expect(image).to eq(image)
    end
  end

  context "with custom options" do
    include_context "custom mongo connection"
    include_context "mongo #retrieve setup"

    it "retrieves the file from custom grid" do
      image = subject.retrieve("1234", :host => "123.456.789.012", :port => 71072, :database => "images", :grid => "mysite")
      expect(image).to eq(image)
    end
  end
end
