# frozen_string_literal: true

module HexletCode
  autoload :Tag, 'hexlet_code/tag'
  autoload :Base, 'hexlet_code/elements/base'

  class Textarea < Base
    NAME = 'textarea'
    DEFAULT_ATTRIBUTES = { rows: 40, cols: 20 }.freeze

    def initialize(attributes)
      raise "Should have required 'value' attribute" unless attributes[:value]

      @value = attributes[:value]
      super(attributes.except(:value))
    end

    def render
      Tag.build(NAME, { **DEFAULT_ATTRIBUTES, **@attributes }) { @value }
    end
  end
end
