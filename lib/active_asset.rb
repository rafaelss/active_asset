require "active_asset/version"
require "active_asset/configuration"
require "active_asset/storage"
require "active_asset/serializer"

module ActiveAsset
  def self.configuration
    @configuration || Configuration.new
  end

  def self.configure
    yield configuration
  end
end
