# frozen_string_literal: true

require 'test_helper'
require 'json'

class TestHexletCode < Minitest::Test
  FIXTURES_PATH = 'test/fixtures/'
  User = Struct.new(:name, :job)
  def setup
    @test_user = User.new('rob', 'hexlet')
  end

  def prepare_fixture(name)
    fixture = File.read("#{FIXTURES_PATH}#{name}")
    name.include?('html') ? prepare_html(fixture) : fixture
  end

  def remove_new_lines(text)
    text.gsub(/\n/, '')
  end

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def prepare_html(html)
    html.gsub(/(>)\s+|\s+(<)/, '\1\2')
  end

  def test_basic_form
    assert HexletCode.form_for(@test_user) == prepare_fixture('basic_form.html')
  end

  def test_basic_form_attributes_given
    result = HexletCode.form_for(@test_user, url: '/users')
    assert result == prepare_fixture('basic_form_with_attributes.html')
  end

  def test_build_simple_nested_form
    result = HexletCode.form_for(@test_user) do |f|
      f.input :name
    end

    prepared_result = remove_new_lines(result)
    assert prepared_result == prepare_fixture('simple_nested_form.html')
  end

  def test_build_nested_form_with_textarea
    result = HexletCode.form_for @test_user do |f|
      f.input :name
      f.input :job, as: :text
    end
    prepared_result = remove_new_lines(result)
    assert prepared_result == prepare_fixture('nested_form_with_textarea.html')
  end

  def test_build_nested_form_with_textarea_and_additional_attrs
    result = HexletCode.form_for @test_user do |f|
      f.input :name, class: 'user-input'
      f.input :job, as: :text, rows: 50, cols: 50
    end
    prepared_result = remove_new_lines(result)
    assert prepared_result == prepare_fixture('nested_form_with_textarea_and_additional_attrs.html')
  end

  def test_not_given_field
    HexletCode.form_for @test_user do |f|
      f.input :name, class: 'user-input'
      f.input :job, as: :text, rows: 50, cols: 50
      f.input :age
    end
  rescue StandardError => e
    assert e.to_s.include?("undefined method `age' for")
  end

  def test_build_nested_form_with_submit
    result = HexletCode.form_for @test_user do |f|
      f.input :name, class: 'user-input'
      f.input :job, as: :text, rows: 50, cols: 50
      f.submit 'Wow'
    end
    prepared_result = remove_new_lines(result)
    assert prepared_result == prepare_fixture('nested_form_with_submit.html')
  end

  def test_raw
    result = HexletCode.form_for(@test_user) do |f|
      f.input :name
      f.output_type = :raw
    end

    assert JSON.parse(prepare_fixture('raw.json')) == JSON.parse(JSON.generate(result))
  end
end
