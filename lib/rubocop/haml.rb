# frozen_string_literal: true

module RuboCop
  module Haml
    autoload :RubyClip, 'rubocop/haml/ruby_clip'
    autoload :RubyClipper, 'rubocop/haml/ruby_clipper'
    autoload :RubyExtractor, 'rubocop/haml/ruby_extractor'
  end
end

require_relative 'haml/plugin'
require_relative 'haml/version'
