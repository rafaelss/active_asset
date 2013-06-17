require File.join(Gem::Specification.find_by_name("mongo").gem_dir, "lib/mongo")

module ActiveAsset
  module Storage
    class Mongo
      def store(file)
        grid.put(file).to_s
      end

      def retrieve(uid)
        grid.get(uid)
      end

      def destroy(uid)
        grid.delete(uid)
      end

      protected

      def grid
        @grid ||= ::Mongo::Grid.new(db)
      end

      def db
        @db ||= connection.db("assets")
      end

      def connection
        @connection ||= ::Mongo::Connection.new("localhost", 27017)
      end
    end
  end
end
