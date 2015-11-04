module Spotify

  module Models

    class TrackLink

      attr_reader :external_urls, :href, :id, :type, :uri

      def initialize(args = {})
        @href          = args[:href]
        @id            = args[:id]
        @type          = args[:type]
        @uri           = args[:uri]

        # HACK: Using JSON while the other classes aren't available.
        @external_urls = args[:external_urls]
      end

    end

  end

end
