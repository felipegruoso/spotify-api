module Spotify

  module Models

    class PlaylistTrack

      attr_reader :added_at, :added_by, :is_local, :track

      def initialize(args = {})
        args = args.with_indifferent_access

        @is_local = args[:is_local]
        @track    = Track.new(args[:name])

        # HACK: Using JSON while the other classes aren't available.
        @added_at = args[:added_at]
        @added_by = args[:added_by]
      end

    end

  end

end
