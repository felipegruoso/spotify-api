module Spotify

  module Models

    class Cursor

      attr_reader :after

      def initialize(args = {})
        args = args.with_indifferent_access

        @after = args[:after]
      end

    end

  end

end
