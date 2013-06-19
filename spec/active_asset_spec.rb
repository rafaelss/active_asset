require "spec_helper"

describe ActiveAsset do
  describe "#configuration" do
    it "returns a new configuration instance" do
      expect(ActiveAsset.configuration).to be_instance_of(ActiveAsset::Configuration)
    end
  end

  describe "#configure" do
    it "yields the configuration instance" do
      ActiveAsset.configure do |c|
        expect(c).to be_instance_of(ActiveAsset::Configuration)
      end
    end
  end
end
