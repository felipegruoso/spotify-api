module Spotify

  module Models

    class Full::Track < Models::Track

      attr_reader :album, :external_ids, :popularity

      #
      # Sets the arguments to its variables.
      #
      # @param [Hash] args the arguments that will be placed on each variable.
      #
      # @return [Full::Track] a full track object.
      #
      def initialize(args = {})
        super(args)

        args = Hash(args).with_indifferent_access

        # Objects
        album        = Spotify::Models::Simplified::Album.new(args[:album])
        external_ids = Spotify::Models::ExternalID.new(args[:external_ids])

        @album        = album
        @external_ids = external_ids
        @popularity   = args[:popularity]
      end

    end

  end

end
