# frozen_string_literal: true
module HexletCode
  class Base
    def initialize(attributes)
      @attributes = attributes
    end

    def render
      raise "Should have render method"
    end
  end
end
