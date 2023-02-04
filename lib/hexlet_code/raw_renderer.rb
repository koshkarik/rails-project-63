# frozen_string_literal: true

module HexletCode
  autoload :Tag, 'hexlet_code/tag'

  module RawRenderer
    def self.render(content)
      content
    end
  end
end
