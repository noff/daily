# Добавить simple_form с Bootstrap

## Шаги

1. Добавить `gem "simple_form"` в `Gemfile`
2. Запустить `bundle install`
3. Запустить генератор `rails generate simple_form:install --bootstrap` — создаст инициализаторы с Bootstrap-классами (`config/initializers/simple_form.rb`, `simple_form_bootstrap.rb`) и локали
4. Обновить форму в `app/views/users/new.html.erb` на использование `simple_form_for` с Bootstrap-обёрткой
