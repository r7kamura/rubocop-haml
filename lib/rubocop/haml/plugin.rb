# frozen_string_literal: true

require 'lint_roller'

module RuboCop
  module Haml
    # A plugin that integrates rubocop-haml with RuboCop's plugin system.
    class Plugin < LintRoller::Plugin
      def about
        LintRoller::About.new(
          name: 'rubocop-haml',
          version: VERSION,
          homepage: 'https://github.com/r7kamura/rubocop-haml',
          description: 'RuboCop plugin for Haml template.'
        )
      end

      def supported?(context)
        context.engine == :rubocop
      end

      def rules(_context)
        RuboCop::Runner.ruby_extractors.unshift(RuboCop::Haml::RubyExtractor)

        LintRoller::Rules.new(
          type: :path,
          config_format: :rubocop,
          value: Pathname.new(__dir__).join('../../../config/default.yml')
        )
      end
    end
  end
end
