# frozen_string_literal: true

require_relative "hexlet_code/version"
require_relative("hexlet_code/form_builder")

module HexletCode
  class Error < StandardError; end
  # Your code goes here...

  def self.form_for(entity, attributes = {})
    FormBuilder.new(entity, attributes) { |f| yield(f) if block_given? }.build
  end
end
