module Spotify

  module Models

    class Folowers

      attr_reader :href, :total

      def initialize(args = {})
        args = args.with_indifferent_access

        @href  = args[:href]
        @total = args[:total]
      end

    end

  end

end