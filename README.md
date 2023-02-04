![Actions Status](https://github.com/koshkarik/rails-project-63/workflows/hexlet-check/badge.svg)

## Simple form generator

### Installation
Add this line to your application's Gemfile:

```gem 'hexlet_code'```

And then execute:

```$ bundle install```

Or install it yourself as:

```$ gem install hexlet_code```

### Usage
```ruby
user = Struct.new(:name, :job).new('John Doe', 'Hexlet')

HexletCode.form_for user do |f|
  f.input :name, class: 'user-input'
  f.input :job, as: :text
  f.submit 'Submit'
end
```

(for raw format - ```f.output_format = 'raw'```)

### Result
```html
<form action="#" method="post">
    <label for="name">Name</label>
    <input type="text" value="John Doe" class="user-input" name="name">
    <label for="job">Job</label>
    <textarea rows="50" cols="50" name="job">Hexlet</textarea>
    <input type="submit" value="Submit">
</form>
```

### Development
After checking out the repo, run bin/setup to install dependencies. You can also run bin/console for an interactive prompt that will allow you to experiment.