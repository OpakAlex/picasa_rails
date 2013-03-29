module Utils
  module Picasa
    module Base

      def initialize raw, &block
        @raw = raw
        block.call(self) if block_given?
      end

      def summary
        get("summary")
      end

      def id
        get("gphoto$id")
      end

      def title
        get("title")
      end

      def author
        get("gphoto$nickname")
      end

      def updated
        get("updated")
      end

      def published
        get("published")
      end

      def thumb
        @raw["media$group"]["media$thumbnail"].first["url"]
      end

      def get(path, key="$t")
        @raw[path][key]
      end

    end
  end
end