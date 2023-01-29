# frozen_string_literal: true

module HexletCode
  autoload :Tag, 'hexlet_code/tag'
  autoload :Base, 'hexlet_code/elements/base'

  class Label < Base
    NAME = 'label'
    DEFAULT_ATTRIBUTES = {}.freeze

    def initialize(attributes)
      raise "Label should have required 'for' attribute" unless attributes[:for]

      @for = attributes[:for]
      super(attributes)
    end

    def render
      Tag.build(NAME, { for: @for, **DEFAULT_ATTRIBUTES }) { @for.capitalize }
    end
  end
end
