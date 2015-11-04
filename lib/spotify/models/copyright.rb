module Spotify

  module Models

    class Copyright

      attr_reader :text, :type

      def initialize(args = {})
        args = args.with_indifferent_access

        @text = args[:text]
        @type = args[:type]
      end

    end

  end

end
