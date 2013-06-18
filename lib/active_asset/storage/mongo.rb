require File.join(Gem::Specification.find_by_name("mongo").gem_dir, "lib/mongo")

module ActiveAsset
  module Storage
    class Mongo
      def initialize
        @connections = {}
        @dbs = {}
        @grids = {}
      end

      def store(file, options = {})
        grid(options.delete(:grid), options).put(file).to_s
      end

      def retrieve(uid, options = {})
        grid(options.delete(:grid), options).get(BSON::ObjectId.from_string(uid))
      rescue ::Mongo::GridFileNotFound
        raise NotFound
      end

      def destroy(uid, options = {})
        grid(options.delete(:grid), options).delete(BSON::ObjectId.from_string(uid))
      end

      protected

      def grid(name, options)
        db = database(options.delete(:database), options)
        ::Mongo::Grid.new(db, name || "fs")
      end

      def database(name, options)
        connection(options.delete(:host), options.delete(:port)).
          db(name || "active_asset")
      end

      def connection(host, port)
        host ||= "localhost"
        port ||= 27017
        @connections["#{host}:#{port}"] ||= ::Mongo::Connection.new(host, port)
      end
    end
  end
end
