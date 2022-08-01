# frozen_string_literal: true

module RuboCop
  module Haml
    RubyClip = ::Struct.new(
      :code,
      :offset,
      keyword_init: true
    )
  end
end
