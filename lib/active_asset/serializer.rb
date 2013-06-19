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
    rescue ArgumentError, OpenSSL::Cipher::CipherError
      raise DecodeError, "The given string can't be decrypted, probably because string is empty or password is invalid"
    end
  end
end
