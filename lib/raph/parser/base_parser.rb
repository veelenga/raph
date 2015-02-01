module Raph
  module Parser
    # Base class for all argument parsers
    class BaseParser

      # Unique id of parser
      def id
        'base'
      end

      # Parses arguments (depends on implementation).
      # Returns results of parsing.
      def parse
        # skip
      end
    end
  end
end
