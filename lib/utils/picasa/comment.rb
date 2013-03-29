module Utils
  module Picasa
    class Comment
      include Utils::Picasa::Base

      def content
        get("content")
      end


      def self.create album_id, opts={}
        opts.update(content: string_comment(opts[:content]))
        Utils::Picasa::Api.create_comment(album_id, opts)
      end

      private

      def self.string_comment content
        <<-"EOF"
        <entry xmlns="http://www.w3.org/2005/Atom">
        <content>#{content}</content>
        <category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#comment"/>
        </entry>
        EOF
      end

    end
  end
end