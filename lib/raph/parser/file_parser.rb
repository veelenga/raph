require 'raph/parser/base_parser'

module Raph
  module Parser
    # Argument is considered as file argument if and only if
    # corresponding file exist on file system and match
    # current argument.
    #
    # Example:
    #  'test.rb' - file in current directory with name 'test.rb'
    #  '*.rb' - all files in current directory with extension 'rb'
    #  '**/*.xml' - all files in current directory and directories
    #             that are in this directory with extension 'xml'
    class FileParser
      def initialize(args)
        @args = args
      end

      def parse
        files = []
        @args.each do |a|
          files.concat Dir[a]
        end
        files.uniq
      end
    end
  end
end
