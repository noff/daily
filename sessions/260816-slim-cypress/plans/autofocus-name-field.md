# Автофокус на поле "Имя" в форме создания пользователя

## Изменение

**Файл:** `app/views/users/new.html.erb` (строка 6)

Добавить `autofocus: true` к полю `:name`:

```diff
- <%= f.input :name, placeholder: "Имя", label: false %>
+ <%= f.input :name, placeholder: "Имя", label: false, input_html: { autofocus: true } %>
```

При открытии страницы `/users/new` курсор автоматически будет установлен в поле ввода имени.
