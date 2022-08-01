# frozen_string_literal: true

require 'rubocop'

RuboCop::Runner.ruby_extractors.unshift(RuboCop::Haml::RubyExtractor)

RuboCop::ConfigLoader.instance_variable_set(
  :@default_configuration,
  RuboCop::Haml::ConfigLoader.call
)
