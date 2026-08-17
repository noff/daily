# Настройка деплоя через Kamal

## Обзор

Rails 8.1 приложение с SQLite (Solid Cache/Queue/Cable), Thruster. Деплой на один сервер 194.104.230.90, пользователь `daily`, домен `daily.r46.dev`. SSL через certbot (nginx в качестве reverse proxy перед kamal-proxy).

## Изменения в файлах

### 1. `config/deploy.yml` — полная перенастройка

- **Сервер**: 194.104.230.90
- **SSH-пользователь**: `daily`
- **Реестр**: локальный на сервере (`localhost:5555`), билд тоже на сервере через `builder.remote` (нативный amd64, без эмуляции QEMU на Mac)
- **Proxy**: `host: daily.r46.dev`, `ssl: false` (SSL через nginx+certbot)
- **Volumes**: `/home/daily/daily/storage:/rails/storage` — SQLite базы (primary, cache, queue, cable) и файлы Active Storage монтируются на хост
- **Accessory registry**: Docker registry (registry:2) на порту 5555, данные в `/home/daily/daily/registry`

### 2. `config/environments/production.rb`

- Включить `config.assume_ssl = true` и `config.force_ssl = true` (SSL терминируется на nginx)
- Настроить `ssl_options` — исключить healthcheck `/up` из редиректа
- Установить `config.hosts` = `daily.r46.dev`

### 3. Nginx конфиг (справочный файл)

Создам файл `config/nginx/daily.conf` — конфиг для nginx, который:
- Слушает 80 → редирект на HTTPS (кроме ACME challenge)
- Слушает 443 с SSL (certbot сертификаты)
- Проксирует на `127.0.0.1:80` (kamal-proxy) через отдельный upstream

**Важно**: после первого `kamal setup` нужно будет перенастроить kamal-proxy на порт 8080 командой:
```
kamal proxy reboot --publish 127.0.0.1:8080:80 --publish 127.0.0.1:8443:443
```
И nginx будет проксировать на `127.0.0.1:8080`.

## Шаги настройки сервера (выполняются вручную)

1. **Docker** — должен быть установлен, пользователь `daily` в группе `docker`
2. **Nginx + certbot**:
   ```
   sudo apt install nginx certbot python3-certbot-nginx
   sudo certbot --nginx -d daily.r46.dev
   ```
3. **Директории**:
   ```
   mkdir -p /home/daily/daily/storage /home/daily/daily/registry
   ```
4. **Docker insecure registry** — добавить в `/etc/docker/daemon.json`:
   ```json
   { "insecure-registries": ["localhost:5555"] }
   ```
   И перезапустить Docker.

## Порядок деплоя

1. Настроить сервер (Docker, nginx, certbot, директории)
2. `kamal setup` — первый деплой (поднимет registry, app, kamal-proxy)
3. `kamal proxy reboot --publish 127.0.0.1:8080:80` — переместить proxy на внутренний порт
4. Скопировать nginx конфиг, `sudo nginx -t && sudo systemctl reload nginx`
5. Проверить `https://daily.r46.dev`
