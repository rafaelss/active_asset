require "spec_helper"

describe ActiveAsset::Serializer, "#encode" do
  it "returns hash encrypted" do
    encrypted = subject.encode({ :id => "51bf98def4e3524da6000001", :d => "50x50#" }, "foo")
    expect(encrypted).to eq("s3KztraDlBtX2cufmRry6DE58vLan6+DgfVBPmK00ssMpfQN6Iklw5IWyLnpFIxz")
  end
end
