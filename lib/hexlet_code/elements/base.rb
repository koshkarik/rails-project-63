# frozen_string_literal: true

class Base
  def initialize(attributes)
    @attributes = attributes
  end

  def render
    raise "Should have render method"
  end
end
