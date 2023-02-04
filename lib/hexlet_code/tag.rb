# frozen_string_literal: true

module HexletCode
  class Tag
    def self.build(tag_name, attributes = {})
      attributes_list = attributes.map { |key, value| " #{key}=\"#{value}\"" }
      opening_tag = "<#{tag_name}#{attributes_list.join}>"
      return opening_tag unless block_given?

      content = yield
      "#{opening_tag}#{content}</#{tag_name}>"
    end
  end
end
