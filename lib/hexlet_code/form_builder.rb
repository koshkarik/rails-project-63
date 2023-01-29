# frozen_string_literal: true

module HexletCode
  autoload :Tag, "hexlet_code/tag"
  autoload :Label, "hexlet_code/elements/label"
  autoload :Input, "hexlet_code/elements/input"
  autoload :Textarea, "hexlet_code/elements/textarea"

  class FormBuilder
    def initialize(entity, attributes = {})
      @entity = entity
      @attributes = attributes
      @form_content = []
      yield self if block_given?
    end

    def input(name, attrubutes = {})
      value = @entity.public_send(name)
      add_form_content(:input, { **attrubutes, value: value, name: name })
    end

    def submit(value = "Save")
      add_form_content(:input, type: "Submit", value: value, as: :submit)
    end

    def build
      Tag.build("form", action: @attributes[:url] || "#", method: "post") do
        content = @form_content.join("\n")
        content.empty? ? "" : "\n#{content}\n"
      end
    end

    private

    def render_item(tag_name, attributes = {})
      as = attributes[:as]
      prepared_attributes = attributes.except(:as)
      if tag_name == :input && as == :text
        [Label.new(for: attributes[:name]).render, Textarea.new(prepared_attributes).render]
      elsif tag_name == :input && as == :submit
        [Input.new(prepared_attributes).render]
      elsif tag_name == :input
        [Label.new(for: attributes[:name]).render, Input.new(prepared_attributes).render]
      else
        raise "Unknown element in render"
      end
    end

    def add_form_content(name, attributes = {})
      elements = render_item(name, attributes)
      elements.each { |item| @form_content << item }
    end
  end
end