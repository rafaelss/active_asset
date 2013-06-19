require "spec_helper"
require "active_asset/active_record"

class User < ActiveRecord::Base
  include ActiveAsset::ActiveRecord
  mount :avatar
end

class Shop < ActiveRecord::Base
  include ActiveAsset::ActiveRecord
  mount :logo do
    { :grid => "bar" }
  end
end

describe ActiveAsset::ActiveRecord do
  let(:options) { {} }
  let(:model) { User.new }
  let(:mount) { :avatar }

  let(:image) { File.open("spec/fixtures/image.gif") }

  it "generates accessor in the model" do
    model.avatar = image
    expect(model.avatar).to eq(image)
  end

  it_behaves_like "a savable active record model with files"

  it_behaves_like "a destroyable active record model with files" do
    let(:model) { User.first }

    before do
      ActiveRecord::Base.connection.insert("INSERT INTO users (name, avatar_uid) VALUES ('Fulano', '51bf98def4e3524da6000001')")
    end
  end

  context "with custom options" do
    let(:options) { { :grid => "bar" } }
    let(:model) { Shop.new }
    let(:mount) { :logo }

    it "generates accessor in the model" do
      model.logo = image
      expect(model.logo).to eq(image)
    end

    it_behaves_like "a savable active record model with files"

    it_behaves_like "a destroyable active record model with files" do
      let(:model) { Shop.first }

      before do
        ActiveRecord::Base.connection.insert("INSERT INTO shops (name, logo_uid) VALUES ('Bar', '51bf98def4e3524da6000001')")
      end
    end
  end
end
