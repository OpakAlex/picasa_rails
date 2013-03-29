module Utils
  module Picasa
    module HTTP
      API_URL = "https://picasaweb.google.com"

      extend self

      def get(url, opts={})
        opts.merge!(alt: "json")
        url = "#{API_URL}/#{url}"
        http = Curl.get(url, opts) do |curl|
          curl.headers.update(prepare_header(opts))
        end
        JSON.parse(http.body_str)["feed"]["entry"]
      end

      def post url, opts
        url = "#{API_URL}/#{url}"
        http = Curl.post(url, opts[:content]) do |curl|
          curl.headers.update(prepare_header(opts))
        end
        http.status == "201 Created" ? true : false
      end

      private

      def prepare_header opts
        headers = {}
        headers["User-Agent"] = "picasa_app"
        if opts[:alt].present? && opts[:alt] == "json"
          headers["Content-Type"] = "application/json"
        else
          headers["Content-Type"] = "application/atom+xml"
        end
        headers["Authorization"] = opts.delete(:token) if opts[:token].present?
        headers
      end
    end
  end
end