module Spotify

  module Models

    class Full::Artist < Models::Artist

      attr_reader :followers, :genres, :images, :popularity

      #
      # Sets the arguments to its variables.
      #
      # @param [Hash] args the arguments that will be placed
      #               on each variable.
      #
      # @return [Full::Artist] a full album object.
      #
      def initialize(args = {})
        super(args)

        args = Hash(args).with_indifferent_access

        # Arrays
        images = Array(args[:images]).map { |i| Spotify::Models::Image.new(i) }

        # Objects
        external_ids = Spotify::Models::ExternalID.new(args[:external_ids])
        follower     = Spotify::Models::Follower.new(args[:followers])

        @followers  = follower
        @genres     = args[:genres]
        @images     = images
        @popularity = args[:popularity]
      end

    end

  end

end
