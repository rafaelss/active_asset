require "aescrypt"
require "base64"
require "json"

module ActiveAsset
  class Serializer
    class DecodeError < StandardError; end

    def encode(hash, password)
      AESCrypt.encrypt(JSON.dump(hash), password).tr("\n=", "")
    end

    def decode(string, password)
      JSON.load(AESCrypt.decrypt(string, password))
    rescue OpenSSL::Cipher::CipherError
      raise DecodeError, "The given string can't be decrypted, probably by an invalid password"
    end
  end
end
