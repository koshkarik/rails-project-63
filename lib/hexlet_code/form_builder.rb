# frozen_string_literal: true

module HexletCode
  autoload :Tag, 'hexlet_code/tag'
  autoload :Label, 'hexlet_code/elements/label'
  autoload :Input, 'hexlet_code/elements/input'
  autoload :Textarea, 'hexlet_code/elements/textarea'

  class FormBuilder
    def initialize(entity, form_attributes = {})
      @entity = entity
      @form_attributes = form_attributes
      @form_content = []
      yield self if block_given?
    end

    def input(name, attrubutes = {})
      value = @entity.public_send(name)
      add_form_content(:input, { **attrubutes, value:, name: })
    end

    def submit(value = 'Save')
      add_form_content(:input, type: 'submit', value:, as: :submit)
    end

    def build
      prepared_attributes = {
        action: @form_attributes[:url] || '#',
        method: 'post',
        **@form_attributes.except(:url)
      }
      Tag.build('form', prepared_attributes) do
        content = @form_content.join("\n")
        content.empty? ? '' : "\n#{content}\n"
      end
    end

    private

    def render_item(tag_name, attributes = {})
      raise 'Unknown element in render' unless tag_name == :input

      prepared_attributes = attributes.except(:as)
      case attributes[:as]
      when :text
        [Label.new(for: attributes[:name]).render, Textarea.new(prepared_attributes).render]
      when :submit
        [Input.new(prepared_attributes).render]
      else
        [Label.new(for: attributes[:name]).render, Input.new(prepared_attributes).render]
      end
    end

    def add_form_content(name, attributes = {})
      elements = render_item(name, attributes)
      elements.each { |item| @form_content << item }
    end
  end
end
