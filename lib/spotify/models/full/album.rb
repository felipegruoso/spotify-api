module Spotify

  module Models

    class Full::Album < Models::Album

      attr_reader :artists, :copyrights, :external_ids, :popularity,
        :release_date, :release_date_precision, :tracks

      #
      # Sets the arguments to its variables.
      #
      # @param [Hash] args the arguments that will be placed on each variable.
      #
      # @return [Full::Album] a full album object.
      #
      def initialize(args = {})
        super(args)

        args = Hash(args).with_indifferent_access

        # Arrays
        artists    = Array(args[:artists]).map    { |a| Artist.new(a)    }
        # copyrights = Array(args[:copyrights]).map { |c| Copyright.new(c) }

        # Objects
        external_ids  = Spotify::Models::ExternalID.new(args[:external_ids])

        # Paging items
        item   = Spotify::Models::Simplified::Track
        tracks = Spotify::Models::Paging.new(args[:tracks], item)

        @artists                = artists
        # @copyrights             = copyrights
        @external_ids           = external_ids
        @popularity             = args[:popularity]
        @release_date           = args[:release_date]
        @release_date_precision = args[:release_date_precision]
        @tracks                 = tracks
      end

    end

  end

end
