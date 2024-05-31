# Ruble

Ruble - это библиотека на языке Ruby для создания и игры в игру, похожую на Wordle, с настраиваемым числом букв в слове. Игра случайным образом выбирает слово из заранее определенного списка, и игроки могут делать попытки, чтобы угадать слово. Библиотека предоставляет обратную связь по каждому предположению, отмечая буквы как зеленые (правильная позиция), желтые (неправильная позиция) или серые (отсутствуют в слове).

## Особенности

- Настраиваемая длина слова
- Настраиваемое максимальное количество попыток
- Обратная связь по каждой попытке с цветовой разметкой
- Простой и легкий в использовании API

## Установка

Добавьте эту строку в ваш Gemfile:

```ruby
gem 'wordle_game'
```


А затем выполните:

```ruby
bundle install
```


Или установите библиотеку самостоятельно с помощью команды:

```ruby
gem install wordle_game
```


Вот пример того, как использовать библиотеку WordleGame:

```ruby
require 'wordle_game'
```

Инициализация игры с длиной слова 5 букв и максимальным количеством попыток 6

```ruby
game = WordleGame::Game.new(5, 6)
```

Делайте попытки
```ruby
result = game.attempt('apple')
puts result # => { status: :correct, result: [:green, :green, :green, :green, :green], attempts_left: 5 }

result = game.attempt('banjo')
puts result # => { status: :incorrect, result: [:grey, :grey, :grey, :grey, :grey], attempts_left: 4 }
```

Для настройки среды разработки выполните:

```
bin/setup
```

Для запуска тестов используйте:

```
bundle exec rspec
```

Вклад
Сообщения об ошибках и запросы на внесение изменений приветствуются на GitHub по адресу https://github.com/lok70/Ruble. Этот проект предназначен для того, чтобы быть безопасным и гостеприимным пространством для сотрудничества, и от участников ожидается соблюдение кодекса поведения.


Лицензия
Библиотека доступна как open-source под условиями MIT License.

Кодекс поведения
Все, кто взаимодействует с проектом WordleGame в репозиториях кода, трекерах ошибок, чатах и почтовых списках, обязаны следовать кодексу поведения.

