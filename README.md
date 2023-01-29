### Hexlet tests and linter status:
[![Actions Status](https://github.com/koshkarik/rails-project-63/workflows/hexlet-check/badge.svg)](https://github.com/koshkarik/rails-project-63/actions)

## Simple form generator

### Usage

```
<%= HexletCode.form_for @user do |f| %>
  <%= f.input :name %>
  <%= f.input :job, as: :text %>
  <%= f.submit 'Submit' %>
<% end %>
```

