module Spotify

  module Models

    class Paging

      attr_reader :href, :items, :limit, :next, :offset, :previous, :total

      #
      # Sets the arguments to its variables.
      #
      # @param [Hash] args the arguments that will be placed on each variable.
      # @param [Spotify::Model] klass the model's class that is represented on
      #   items's array.
      #
      # @return [Paging] a paging object containing the an array of the given
      #   model.
      #
      def initialize(args = {}, klass)
        args = Hash(args).with_indifferent_access

        # Arrays
        items = Array(args[:items]).map { |i| klass.new(i) }

        @href     = args[:href]
        @items    = items
        @limit    = args[:limit]
        @next     = args[:next]
        @offset   = args[:offset]
        @previous = args[:previous]
        @total    = args[:total]
      end

    end

  end

end
