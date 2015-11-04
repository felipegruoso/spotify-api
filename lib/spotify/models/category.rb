module Spotify

  module Models

    class Category

      attr_reader :href, :icons, :id, :name

      def initialize(args = {})
        args  = args.with_indifferent_access
        icons = args[:icons].map { |icon| Spotify::Models::Image.new(icon) }

        @href  = args[:href]
        @icons = icons
        @id    = args[:id]
        @name  = args[:name]
      end

    end

  end

end
