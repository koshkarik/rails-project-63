# frozen_string_literal: true

module HexletCode
  class Tag
    def self.build(tag_name, attributes = {})
      attributes_list = []
      attributes.each do |key, value|
        attributes_list.push("#{key}=\"#{value}\"")
      end
      prepared_attributes = attributes_list.empty? ? '' : " #{attributes_list.join ' '}"
      left_side = "<#{tag_name}#{prepared_attributes}>"
      return left_side unless block_given?

      content = yield
      "#{left_side}#{content}</#{tag_name}>"
    end
  end
end
