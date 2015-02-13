require 'raph/parser/flag_parser'
require 'raph/parser/assignment_parser'
require 'raph/parser/file_parser'

module Raph
  class Raph
    attr_reader :flags, :assignments, :files

    def initialize(args=ARGV)
      flag_parser = Parser::FlagParser.new(args)
      assignment_parser = Parser::AssignmentParser.new(args)
      file_parser = Parser::FileParser.new(args)

      @flags = flag_parser.parse
      @assignments = assignment_parser.parse
      @files = file_parser.parse
    end
  end
end

$raph = Raph::Raph.new
