# frozen_string_literal: true

module HexletCode
  autoload :HtmlRenderer, 'hexlet_code/html_renderer'
  autoload :RawRenderer, 'hexlet_code/raw_renderer'

  class FormBuilder
    attr_accessor :output_type

    DEFAULT_ATTRIBUTES = {
      input: { type: 'text', value: '' },
      textarea: { rows: 40, cols: 20 },
      label: {}
    }.freeze

    def initialize(entity, form_attributes = {})
      @entity = entity
      @output_type = :html
      @form_data = {
        type: :form,
        attributes: {
          action: form_attributes[:url] || '#',
          method: 'post',
          **form_attributes.except(:url)
        },
        children: []
      }

      yield self if block_given?
    end

    def input(name, attributes = {})
      value = @entity.public_send(name)
      prepared_attributes = attributes.except(:as)
      label = prepare_item(:label, { for: name }, name.capitalize)

      if attributes[:as] == :text
        add_form_content([label, prepare_item(:textarea, { **prepared_attributes, name: }, value)])
      else
        add_form_content([label, prepare_item(:input, { **prepared_attributes, value:, name: })])
      end
    end

    def submit(value = 'Save')
      add_form_content([prepare_item(:input, value:, type: :submit)])
    end

    def build
      renderer.render([@form_data])
    end

    private

    def renderer
      case @output_type
      when :html
        HtmlRenderer
      when :raw
        RawRenderer
      else
        raise('Unknown output type')
      end
    end

    def prepare_item(type, attributes, children = nil)
      { type:, attributes: { **DEFAULT_ATTRIBUTES[type], **attributes }, children: }
    end

    def add_form_content(content)
      @form_data[:children].push(*content)
    end
  end
end
