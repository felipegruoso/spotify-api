module Spotify

  module Models

    class Album

      attr_reader :album_type, :artists, :available_markets, :copyrights,
        :external_ids, :external_urls, :genres, :href, :id, :images, :name,
        :popularity, :release_date_precision, :tracks, :type, :uri

      def initialize(args = {})
        args = args.with_indifferent_access

        artists = args[:artists].map { |artist| Artist.new(artist) }

        klass  = Spotify::Models::Track
        tracks = Spotify::Models::Paging.new(args[:tracks], klass)
        # tracks = args[:tracks].map do |track|
        # end

        @album_type             = args[:album_type]
        @artists                = artists
        @available_markets      = args[:available_markets]
        @genres                 = args[:genres]
        @href                   = args[:href]
        @id                     = args[:id]
        @name                   = args[:name]
        @popularity             = args[:popularity]
        @release_date_precision = args[:release_date_precision]
        @type                   = args[:type]
        @uri                    = args[:uri]

        # HACK: Using JSON while the other classes aren't available.
        @copyrights             = args[:copyrights]
        @external_ids           = args[:external_ids]
        @external_urls          = args[:external_urls]
        @images                 = args[:images]
        @tracks                 = tracks
      end

    end

  end

end
