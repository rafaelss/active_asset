require "spec_helper"
require "active_asset/storage/mongo"

describe ActiveAsset::Storage::Mongo, "#retrieve" do
  context "with default options" do
    include_context "default mongo connection"

    it "raise an exception if file is not found" do
      objectid_class = Class.new
      stub_const("BSON::ObjectId", objectid_class)

      objectid = double("objectid", :to_s => "51bf98def4e3524da6000002")
      objectid_class.
        should_receive(:from_string).
        with("51bf98def4e3524da6000002").
        and_return(objectid)

      grid.
        should_receive(:get).
        with(objectid).
        and_raise(Mongo::GridFileNotFound)

      expect { subject.retrieve("51bf98def4e3524da6000002") }.to raise_error(ActiveAsset::Storage::NotFound, "File not found")
    end

    context "and existing files" do
      include_context "mongo #retrieve setup"

      it "retrieves the file from default grid" do
        image = subject.retrieve("51bf98def4e3524da6000001")
        expect(image).to eq(image)
      end
    end
  end

  context "with custom options" do
    include_context "custom mongo connection"
    include_context "mongo #retrieve setup"

    it "retrieves the file from custom grid" do
      image = subject.retrieve("51bf98def4e3524da6000001", :host => "123.456.789.012", :port => 71072, :database => "images", :grid => "mysite")
      expect(image).to eq(image)
    end
  end
end
