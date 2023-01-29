# frozen_string_literal: true

module HexletCode
  autoload :Tag, 'hexlet_code/tag'
  autoload :Base, 'hexlet_code/elements/base'

  class Input < Base
    NAME = 'input'
    DEFAULT_ATTRIBUTES = { type: 'text', value: '' }.freeze

    def render
      Tag.build(NAME, { **DEFAULT_ATTRIBUTES, **@attributes })
    end
  end
end
