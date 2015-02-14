require 'raph/parser/file_parser'
require 'raph/parser/flag_parser'
require 'raph/parser/assignment_parser'

module Raph
  # TODO: class description
  class Raph
    def initialize
      @parsed = {}
      @parsers = []
    end

    def parse(args)
      @all = args.dup

      @parsers.each do |p|
        @parsed[p.id.to_sym] = p.parse(@all)
      end
    end

    def all
      @all.dup
    end

    def add_parser(parser)
      @parsers.push parser
    end

    def method_missing(method_sym, *arguments, &block)
      # TODO: do not accept any arguments or block
      if has_attribute? method_sym
        get_attribute_value method_sym
      else
        super
      end
    end

    private

    # Returns true if this class has dynamic argument 'arg'
    def has_attribute?(arg)
      @parsed.include? arg
    end

    # Returns value of dynamic argument 'arg'
    def get_attribute_value(arg)
      @parsed[arg]
    end
  end

  include Parser

  $raph = Raph.new.tap do |r|
    r.add_parser(FileParser.new)
    r.add_parser(FlagParser.new)
    r.add_parser(AssignmentParser.new)

    r.parse(ARGV)
  end
end

