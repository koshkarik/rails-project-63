# frozen_string_literal: true

module HexletCode
  autoload :Tag, 'hexlet_code/tag'

  module HtmlRenderer
    def self.render(content)
      return '' if content.empty?

      content.map do |item|
        next Tag.build(item[:type], item[:attributes]) unless item[:children]

        Tag.build(item[:type], item[:attributes]) do
          item[:children].is_a?(Array) ? render(item[:children]) : item[:children]
        end
      end.join("\n")
    end
  end
end
