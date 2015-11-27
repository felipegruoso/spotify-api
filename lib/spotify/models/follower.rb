module Spotify

  module Models

    class Follower

      attr_reader :href, :total

      #
      # Sets the arguments to its variables.
      #
      # @param [Hash] args the arguments that will be placed on each variable.
      #
      # @return [Follower] a follower object.
      #
      def initialize(args = {})
        args = Hash(args).with_indifferent_access

        @href  = args[:href]
        @total = args[:total]
      end

    end

  end

end