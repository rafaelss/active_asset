require "spec_helper"
require "active_asset/active_record"

require "active_record"
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
ActiveRecord::Base.connection.create_table(:users, :force => true) do |t|
  t.string :name
  t.string :file_uid
end

class User < ActiveRecord::Base
  include ActiveAsset::ActiveRecord
  mount :file
end

describe ActiveAsset::ActiveRecord do
  let(:model) { User.new }
  let(:image) { File.open("spec/fixtures/image.gif") }

  it "generates accessor in the class" do
    model.file = image
    expect(model.file).to eq(image)
  end

  context "saving" do
    include_context "default mongo connection"

    it "saves the file uid in the respective column" do
      grid.
        should_receive(:put).
        with(image).
        and_return(double("object_id", :to_s => "1234"))

      model.file = image
      model.save

      expect(model.file_uid).to eq("1234")
    end
  end

  context "destroying" do
    include_context "default mongo connection"
    let(:model) { User.first }

    before do
      ActiveRecord::Base.connection.insert("INSERT INTO users (name, file_uid) VALUES ('Fulano', '1234')")
    end

    it "destroys the file in mongo" do
      grid.
        should_receive(:delete).
        with("1234").
        and_return("err" => nil)

      model.destroy
      expect(model.file_uid).to eq(nil)
    end
  end
end
