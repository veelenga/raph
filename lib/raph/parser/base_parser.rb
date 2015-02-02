module Raph
  # This module consists of argument parsers for Humans
  module Parser
    # Argument base class for all argument parsers
    #
    # You can create a custom formatter by subclassing
    # `Raph::Parser::BaseParser` and overriding some methods,
    # or by implementing all the methods by duch typing.
    class BaseParser
      # Unique id of each parser.
      def self.id
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
