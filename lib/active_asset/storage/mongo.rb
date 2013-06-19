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
        grid(options.delete(:grid), options).get(to_object_id(uid))
      rescue ::Mongo::GridFileNotFound
        raise NotFound, "File not found"
      end

      def destroy(uid, options = {})
        grid(options.delete(:grid), options).delete(to_object_id(uid))
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

      def to_object_id(str)
        BSON::ObjectId.from_string(str)
      end
    end
  end
end
