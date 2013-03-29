module Utils
  module Picasa
    class Album

      include Utils::Picasa::Base

      attr_accessor :photos

      def initialize raw, &block
        @photos = []
        super(raw, &block)
      end

      def photos_count
        get("gphoto$numphotos")
      end

      def load_photos limit=3
        @photos = Utils::Picasa::Api.get_photos(id, limit)
      end

    end
  end
end