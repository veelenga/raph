module Raph
  # This module consists of argument parsers for Humans
  module Parser
    # Base class for all argument parsers.
    #
    # You can create a custom parser by subclassing
    # `Raph::Parser::BaseParser` and overriding some methods,
    # or by implementing all the methods by duck typing.
    class BaseParser
      # Parser unique id.
      # If parser class name follows a convention NameParser
      # then it's id will be automatically determined as it's
      # name in snake case plus suffix 's'
      #
      # Example:
      #    FlagParser.new.id                  # => :flags
      #    FileParser.new.id                  # => :files
      #    BaseArgumentParser.new.id          # => :base_arguments
      def id
        name = class_name.gsub(/parser$/i, '')
        name << 's' # make it plural
        to_underscored_sym(name)
      end

      # Parses arguments and returns results of parsing.
      def parse(args)
      end

      protected

      # Returns underscored symbol of string
      # (snake case format).
      def to_underscored_sym(str)
        str.gsub(/^[-]+/, '').
          gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr("-", "_").
          downcase.
          to_sym
      end

      private

      # Returns name of current class.
      def class_name
        self.class.name.split('::').last || ''
      end
    end
  end
end
