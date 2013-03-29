module Utils
  module Picasa
    module Api

      extend self

      def new opts={}
        @user_id = opts[:user_id]
        @token   = "OAuth #{opts[:token]}" if opts[:token].present?
        @albums = []
      end

      def get_albums
        if @albums.empty?
          albums_json = HTTP.get("data/feed/api/user/#{@user_id}", token: @token)
          @albums = albums_json.map do |raw_album|
            Utils::Picasa::Album.new(raw_album)
          end
        end
      end

      def get_albums!
        albums_json = HTTP.get("data/feed/api/user/#{@user_id}", token: @token)
        @albums = albums_json.map do |raw_album|
          Utils::Picasa::Album.new(raw_album)
        end
      end

      def get_photos album_id, limit
        photos_json = HTTP.get("data/feed/api/user/#{@user_id}/albumid/#{album_id}", token: @token)
        photos = []
        if photos_json.present?
          photos = photos_json.first(limit).map do |photo|
            Utils::Picasa::Photo.new(photo)
          end
        end
        photos
      end

      def get_comments album_id, id
        comments_json = HTTP.get("data/feed/api/user/#{@user_id}/albumid/#{album_id}/photoid/#{id}", token: @token)
        if comments_json.present?
          comments_json.map do |comment|
            Utils::Picasa::Comment.new(comment)
          end
        else
          []
        end
      end

      def create_comment album_id, params
        photo_id = params.delete(:photo_id)
        HTTP.post("data/feed/api/user/#{@user_id}/albumid/#{album_id}/photoid/#{photo_id}", params.merge!(token: @token))
      end


      def find(type, id)
        case type
          when :album
            find_album(id)
          else
            nil
        end
      end

      private

      def find_album id
        @albums.detect{|album| album.id == id }
      end

    end
  end
end