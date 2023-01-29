# frozen_string_literal: true

require_relative "base"
require_relative "../tag"

class Label < Base
  NAME = "label"
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
