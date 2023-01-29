![Actions Status](https://github.com/koshkarik/rails-project-63/workflows/hexlet-check/badge.svg)

## Simple form generator

### Usage
```ruby
user = { name: 'John Doe', job: 'Hexlet' }
HexletCode.form_for user do |f|
  f.input :name, class: 'user-input'
  f.input :job, as: :text
  f.submit 'Submit'
end
```

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