module Spotify

  module Models

    class SavedAlbum

      attr_reader :added_at, :album

      def initialize(args = {})
        args = args.with_indifferent_access

        @album    = Album.new(args[:name])

        # HACK: Using JSON while the other classes aren't available.
        @added_at = args[:added_at]
      end

    end

  end

end
