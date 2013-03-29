module Utils
  module Picasa
    class Photo

      include Utils::Picasa::Base

      attr_accessor :comments

      def initialize raw, &block
        super(raw, &block)
        load_comments()
      end

      def comments_count
        @comments.size
      end

      def path
        @raw["media$group"]["media$content"].first["url"]
      end

      def album_id
        get("gphoto$albumid")
      end

      def load_comments
        @comments = Utils::Picasa::Api.get_comments(album_id, id)
      end

    end
  end
end