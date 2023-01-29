# frozen_string_literal: true

require 'test_helper'

class TestHexletCode < Minitest::Test
  User = Struct.new(:name, :job)
  def setup
    @test_user = User.new('rob', 'hexlet')
  end

  def remove_new_lines(text)
    text.gsub(/\n/, '')
  end

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_basic_form
    assert HexletCode.form_for(@test_user) == '<form action="#" method="post"></form>'
  end

  def test_basic_form_attributes_given
    result = HexletCode.form_for(@test_user, url: '/users')
    assert result == '<form action="/users" method="post"></form>'
  end

  def test_build_simple_nested_form
    result = HexletCode.form_for(@test_user) do |f|
      f.input :name
    end

    prepared_result = remove_new_lines(result)
    assert prepared_result == '<form action="#" method="post">'\
    '<label for="name">Name</label><input type="text" value="rob" name="name"></form>'
  end

  def test_build_nested_form_with_textarea
    result = HexletCode.form_for @test_user do |f|
      f.input :name
      f.input :job, as: :text
    end
    prepared_result = remove_new_lines(result)
    assert prepared_result == '<form action="#" method="post">'\
    '<label for="name">Name</label>'\
    '<input type="text" value="rob" name="name">'\
    '<label for="job">Job</label>'\
    '<textarea rows="40" cols="20" name="job">hexlet</textarea></form>'
  end

  def test_build_nested_form_with_textarea_and_additional_attrs
    result = HexletCode.form_for @test_user do |f|
      f.input :name, class: 'user-input'
      f.input :job, as: :text, rows: 50, cols: 50
    end
    prepared_result = remove_new_lines(result)
    assert prepared_result == '<form action="#" method="post">'\
    '<label for="name">Name</label>'\
    '<input type="text" value="rob" class="user-input" name="name">'\
    '<label for="job">Job</label>'\
    '<textarea rows="50" cols="50" name="job">hexlet</textarea></form>'
  end

  def test_not_given_field
    begin
      HexletCode.form_for @test_user do |f|
        f.input :name, class: 'user-input'
        f.input :job, as: :text, rows: 50, cols: 50
        f.input :age
      end
    rescue StandardError => e
      puts e
      assert e.to_s.include?("undefined method `age' for")
    end
  end

  def test_build_nested_form_with_submit
    result = HexletCode.form_for @test_user do |f|
      f.input :name, class: 'user-input'
      f.input :job, as: :text, rows: 50, cols: 50
      f.submit 'Wow'
    end
    prepared_result = remove_new_lines(result)
    assert prepared_result == '<form action="#" method="post">'\
    '<label for="name">Name</label>'\
    '<input type="text" value="rob" class="user-input" name="name">'\
    '<label for="job">Job</label>'\
    '<textarea rows="50" cols="50" name="job">hexlet</textarea>'\
    '<input type="submit" value="Wow"></form>'
  end
end
