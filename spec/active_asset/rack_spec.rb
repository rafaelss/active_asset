require "spec_helper"
require "active_asset/rack"

describe ActiveAsset::Rack, :rack do
  def app
    described_class.new
  end

  before do
    ActiveAsset.configure do |c|
      c.secret = "foo"
    end
  end

  context "for existing files" do
    let(:storage) { ActiveAsset::Storage::Mongo.new }
    let(:image) { File.open("spec/fixtures/image.gif", "r") }
    let(:uid) { storage.store(image) }
    let(:encoded) { ActiveAsset::Serializer.new.encode({ :id => uid }, "foo") }

    it "returns 200 if file is found" do
      get "/foo.png?h=#{encoded}"

      puts last_response.body
      expect(last_response).to be_ok
    end
  end

  it "returns 404 if file is not found" do
    get "/foo.png?h=RUlNjF8uJdLDVHza/i0WMvjn2PfwMaa7x8/XwmkuG+8DDd7YtzAxNLbFAP8o/ouC"

    expect(last_response).to be_not_found
  end

  it "returns 400 if hash is invalid" do
    get "/foo.png?h=foo"

    expect(last_response).to be_bad_request
  end
end
