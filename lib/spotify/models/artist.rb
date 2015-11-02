module Spotify

  module Models

    class Artist

      attr_reader :external_urls, :followers, :genres, :href,
        :id, :images, :name, :popularity, :type, :uri

      def initialize(args = {})
        args = args.with_indifferent_access

        @genres        = args[:genres]
        @href          = args[:href]
        @id            = args[:id]
        @name          = args[:name]
        @popularity    = args[:popularity]
        @type          = args[:type]
        @uri           = args[:uri]

        # HACK: Using JSON while the other classes aren't available.
        @external_urls = args[:external_urls]
        @followers     = args[:followers]
        @images        = args[:images]
      end

    end

  end

end
