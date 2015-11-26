module Spotify

  module Models

    class CursorbasedPaging

      attr_reader :href, :items, :limit, :next, :cursors, :total

      def initialize(args = {}, klass)
        args = args.with_indifferent_access

        @href    = args[:href]
        @items   = args[:items].map { |item| klass.new(item) }
        @limit   = args[:limit]
        @next    = args[:next]
        @total   = args[:total]
        @cursors = Cursor.new(args[:cursors])
      end

    end

  end

end
