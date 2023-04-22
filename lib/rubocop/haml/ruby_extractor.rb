# frozen_string_literal: true

require 'rubocop'
require 'hamli'

module RuboCop
  module Haml
    # Extract Ruby codes from Haml template.
    class RubyExtractor
      class << self
        # @param [RuboCop::ProcessedSource] processed_source
        # @return [Array<RuboCop::ProcessedSource>, nil]
        def call(processed_source)
          new(processed_source).call
        end
      end

      # @param [RuboCop::ProcessedSource] processed_source
      def initialize(processed_source)
        @processed_source = processed_source
      end

      # @return [Array<RuboCop::ProcessedSource>, nil]
      def call
        return unless supported_file_path_pattern?

        ruby_ranges.map do |(begin_, end_)|
          clip = RubyClipper.new(template_source[begin_...end_]).call

          processed_source = ::RuboCop::ProcessedSource.new(
            clip[:code],
            @processed_source.ruby_version,
            file_path
          )
          processed_source.config = @processed_source.config
          processed_source.registry = @processed_source.registry

          {
            offset: begin_ + clip[:offset],
            processed_source: processed_source
          }
        end
      end

      private

      # @return [Array] Haml AST, represented in S-expression.
      def ast
        ::Hamli::Filters::Interpolation.new.call(
          ::Hamli::Parser.new(file: file_path).call(template_source)
        )
      end

      # @return [String, nil]
      def file_path
        @processed_source.path
      end

      # @return [Array<Array<Integer>>]
      def ruby_ranges
        result = []
        traverse(ast) do |begin_, end_|
          result << [begin_, end_]
        end
        result
      end

      # @return [Boolean]
      def supported_file_path_pattern?
        file_path&.end_with?('.haml')
      end

      def traverse(node, &block)
        return unless node.instance_of?(::Array)

        block.call(node[2], node[3]) if node[0] == :hamli && node[1] == :position
        node.each do |element|
          traverse(element, &block)
        end
      end

      # @return [String]
      def template_source
        @processed_source.raw_source
      end
    end
  end
end
