module Spotify

  module Models

    class Paging

      attr_reader :href, :items, :limit, :next, :offset, :previous, :total

      def initialize(args = {}, klass)
        args = args.with_indifferent_access

        @href     = args[:href]
        @items    = args[:items].map { |item| klass.new(item) }
        @limit    = args[:limit]
        @next     = args[:next]
        @offset   = args[:offset]
        @previous = args[:previous]
        @total    = args[:total]
      end

    end

  end

end
