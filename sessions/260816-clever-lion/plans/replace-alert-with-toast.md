# Замена alert на Bootstrap toast

## Файл
`app/views/layouts/application.html.erb`

## Изменение

Заменить блок flash-уведомления (строки 27–29):

```diff
- <% if flash[:notice] %>
- <div class="alert text-bg-success rounded-0"><%= flash[:notice] %></div>
- <% end %>
+ <% if flash[:notice] %>
+ <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1090;">
+   <div class="toast align-items-center text-bg-success border-0 show" role="alert" data-bs-autohide="true" data-bs-delay="5000">
+     <div class="d-flex">
+       <div class="toast-body"><%= flash[:notice] %></div>
+       <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
+     </div>
+   </div>
+ </div>
+ <% end %>
```

**Что изменится:**
- Toast появится в правом верхнем углу поверх контента
- Автоматически скроется через 5 секунд (`data-bs-delay="5000"`)
- Есть кнопка закрытия (×)
- Стиль `text-bg-success` сохранён
