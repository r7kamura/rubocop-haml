# frozen_string_literal: true

module RuboCop
  module Haml
    autoload :ConfigLoader, 'rubocop/haml/config_loader'
    autoload :RubyClip, 'rubocop/haml/ruby_clip'
    autoload :RubyClipper, 'rubocop/haml/ruby_clipper'
    autoload :RubyExtractor, 'rubocop/haml/ruby_extractor'
  end
end

require_relative 'haml/rubocop_extension'
require_relative 'haml/version'
