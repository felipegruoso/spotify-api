module Spotify

  module Models

    class SavedTrack

      attr_reader :added_at, :track

      def initialize(args = {})
        args = args.with_indifferent_access

        @track    = Track.new(args[:name])

        # HACK: Using JSON while the other classes aren't available.
        @added_at = args[:added_at]
      end

    end

  end

end
