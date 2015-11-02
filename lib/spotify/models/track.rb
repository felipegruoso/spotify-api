module Spotify

  module Models

    class Track

      attr_reader :album, :artists, :external_ids, :external_urls,
        :available_markets, :disc_number, :duration_ms, :explicit,
        :href, :id, :is_playable, :linked_from, :name, :popularity,
        :preview_url, :track_number, :type, :uri

      def initialize(args = {})
        args = args.with_indifferent_access

        @artists           = args[:artists].map { |artist| Artist.new(artist) }
        @available_markets = args[:available_markets]
        @disc_number       = args[:disc_number]
        @duration_ms       = args[:duration_ms]
        @explicit          = args[:explicit]
        @href              = args[:href]
        @id                = args[:id]
        @is_playable       = args[:is_playable]
        @linked_from       = args[:linked_from]
        @name              = args[:name]
        @popularity        = args[:popularity]
        @preview_url       = args[:preview_url]
        @track_number      = args[:track_number]
        @type              = args[:type]
        @uri               = args[:uri]

        # HACK: Using JSON while the other classes aren't available.
        @album             = args[:album]
        @external_ids      = args[:external_ids]
        @external_urls     = args[:external_urls]
      end

    end

  end

end