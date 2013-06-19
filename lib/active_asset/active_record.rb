require "set"

module ActiveAsset
  module ActiveRecord
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      attr_accessor :assets_mounted

      def mount(name, &block)
        setup_accessor(name)

        before_save :save_assets
        before_destroy :destroy_assets

        self.assets_mounted ||= {}
        assets_mounted[name] = block
      end

      protected

      def setup_accessor(name)
        define_method("#{name}=") do |asset|
          instance_variable_set("@#{name}", asset)
        end

        define_method(name) do
          asset = instance_variable_get("@#{name}")
          return asset if asset

          if send("#{name}_uid?")
            asset = asset_storage.retrieve(send("#{name}_uid"))
            send("#{name}=", asset)
          end
          asset
        end
      end
    end

    protected

    def asset_storage
      @storage ||= ActiveAsset::Storage::Mongo.new
    end

    def save_assets
      each_mount do |mount, options, asset|
        send("#{mount}_uid=", asset_storage.store(asset, options))
      end
    end

    def destroy_assets
      each_mount do |mount, options, asset|
        asset_storage.destroy(send("#{mount}_uid"), options)
        send("#{mount}_uid=", nil)
      end
    end

    def each_mount
      self.class.assets_mounted.each do |mount, block|
        options = block.respond_to?(:call) ? block.call : {}
        yield mount, options, instance_variable_get("@#{mount}")
      end
    end
  end
end
