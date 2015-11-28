module Spotify

  module Models

    class Image

      attr_reader :height, :url, :width

      #
      # Sets the arguments to its variables.
      #
      # @param [Hash] args the arguments that will be placed on each variable.
      #
      # @return [Image] an image object.
      #
      def initialize(args = {})
        args = Hash(args).with_indifferent_access

        @height = args[:height]
        @url    = args[:url]
        @width  = args[:width]
      end

    end

  end

end
