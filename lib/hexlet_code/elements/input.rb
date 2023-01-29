# frozen_string_literal: true

require_relative("../tag")
require_relative("base")

class Input < Base
  NAME = "input"
  DEFAULT_ATTRIBUTES = { type: "text", value: "" }.freeze

  def render
    Tag.build(NAME, { **DEFAULT_ATTRIBUTES, **@attributes })
  end
end
