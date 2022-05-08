## Разворачиваем приложение для разработки
Первая сборка, выполнить поочерёдно:

`docker-compose build` - сборка образов.

`docker-compose up --no-start` - создание контейнеров.

`docker-compose run --rm web bash -c 'bundle && bin/rails db:create db:migrate db:seed'` - установка гемов, создание базы

`docker-compose up` - запуск всех контейнеров.

Если надо поставить новые гемы:

`docker-compose run --rm web bundle`

Если обновились пакеты yarn:

`docker-compose run --rm web yarn`