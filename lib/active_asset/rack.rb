require "active_asset"
require "mini_magick"

module ActiveAsset
  class Rack
    def call(env)
      response = ::Rack::Response.new

      begin
        hash = decode_h_param(env)
        set_response_body(response, hash)
      rescue Serializer::DecodeError
        response.status = 400
        response.body = ["Bad Request"]
      rescue ActiveAsset::Storage::NotFound
        response.status = 404
        response.body = ["Not Found"]
      end

      response.finish
    end

    protected

    def storage
      @storage ||= ActiveAsset::Storage::Mongo.new
    end

    def digest_body(body)
      parts = []
      body.each { |part| parts << part }
      string_body = parts.join
      Digest::MD5.hexdigest(string_body) unless string_body.empty?
    end

    def serializer
      @serializer ||= Serializer.new
    end

    def decode_h_param(env)
      request = ::Rack::Request.new(env)
      serializer.decode(request.params["h"].tr(" ", "+"), ActiveAsset.configuration.secret)
    end

    def set_response_body(response, hash)
      io = storage.retrieve(hash["id"])

      if hash["d"] =~ /\dx\d/
        image = MiniMagick::Image.read(io)
        image.resize(hash["d"])
        image.write(response)
      else
        response.body = io
      end
    end
  end
end
