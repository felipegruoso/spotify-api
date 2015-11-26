module Spotify

  module Models

    class ExternalID

      def initialize(args = {})
        args = args.with_indifferent_access

        hsh = {
          isrc: args[:isrc],
          ean:  args[:ean],
          upc:  args[:upc]
        }

        hsh = hsh.reject { |_, v| v.blank? }

        if hsh.present?
          # Generates the keys dynamically
          hsh.each do |k, v|
            key   = k
            value = v

            eval("@#{key} = value")
            class_eval { attr_reader key.to_sym }
          end
        end
      end

    end

  end

end
