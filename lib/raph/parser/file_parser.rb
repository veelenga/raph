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
    class FileParser < BaseParser
      def parse(args)
        args.uniq.each_with_object([]) do |a, files|
          files.concat Dir[a]
        end
      end
    end
  end
end
