require "spec_helper"

describe ActiveAsset::Serializer, "#decode" do
  it "returns a hash" do
    decrypted = subject.decode("s3KztraDlBtX2cufmRry6DE58vLan6+DgfVBPmK00ssMpfQN6Iklw5IWyLnpFIxz", "foo")
    expect(decrypted).to eq("id" => "51bf98def4e3524da6000001", "d" => "50x50#")
  end

  it "raises an error if password is wrong" do
    expect do
      subject.decode("s3KztraDlBtX2cufmRry6DE58vLan6+DgfVBPmK00ssMpfQN6Iklw5IWyLnpFIxz", "bar")
    end.to raise_error(described_class::DecodeError)
  end
end
