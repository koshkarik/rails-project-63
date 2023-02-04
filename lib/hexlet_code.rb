# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  class Error < StandardError; end

  autoload :FormBuilder, 'hexlet_code/form_builder'
  autoload :Tag, 'hexlet_code/tag'

  def self.form_for(entity, attributes = {})
    FormBuilder.new(entity, attributes) { |f| yield(f) if block_given? }.build
  end
end
