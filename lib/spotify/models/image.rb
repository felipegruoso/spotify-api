module Spotify

  module Models

    class Image

      attr_reader :height, :url, :width

      def initialize(args = {})
        args = args.with_indifferent_access

        @height = args[:height]
        @uri    = args[:uri]
        @width  = args[:width]
      end

    end

  end

end
