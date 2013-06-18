require "spec_helper"
require "active_asset/storage/mongo"

describe ActiveAsset::Storage::Mongo, "#destroy" do
  context "with default options" do
    include_context "default mongo connection"
    include_context "mongo #destroy setup"

    it "destroy the file in default grid" do
      hash = subject.destroy("51bf98def4e3524da6000001")
      expect(hash).to eq(hash)
    end
  end

  context "with custom options" do
    include_context "custom mongo connection"
    include_context "mongo #destroy setup"

    it "stores the file in custom grid" do
      uid = subject.destroy("51bf98def4e3524da6000001", :host => "123.456.789.012", :port => 71072, :database => "images", :grid => "mysite")
      expect(hash).to eq(hash)
    end
  end
end
