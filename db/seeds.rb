# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create([
  { title: "Frontend" },
  { title: "Backend" }
]);

Test.create([
  { title: "HTML", category_id: 1 },
  { title: "CSS", category_id: 1 },
  { title: "Javascript", category_id: 1 },
  { title: "Ruby", level: 1, category_id: 2 },
  { title: "Rails", level: 2, category_id: 2 }
]);

Question.create([
  { body: "Как оформляется комментарий в HTML?", test_id: 1 },
  { body: "С помощью какого атрибута можно задать текст для картинки, который будет отображен, если её не удастся загрузить?", test_id: 1 },
  { body: "Каким является следующий адрес ссылки: ./pages/page2.html", test_id: 1 },
  { body: "С помощью какого тега нужно задавать подписи к полям формы?", test_id: 1 },
  { body: "Какое свойство CSS определяет размер текста?", test_id: 2 },
  { body: "Какой атрибут используется для определения встроенных стилей?", test_id: 2 },
  { body: "Какой правильный синтаксис CSS?", test_id: 2 },
  { body: "Какие циклы есть в языке JavaScript?", test_id: 3 },
  { body: "Какие значения можно хранить в переменных?", test_id: 3 },
  { body: "Как называется самый популярный фреймворк языка Ruby для веба?", test_id: 4 }
])

Answer.create([
  { body: "/* комментарий */", question_id: 1 },
  { body: "<!—комментарий -->", correct: true, question_id: 1 },
  { body: "// комментарий", question_id: 1 },
  { body: "popup", question_id: 2 },
  { body: "title", question_id: 2 },
  { body: "alt", correct: true, question_id: 2 },
  { body: "caption", question_id: 2 },
  { body: "Относительным", correct: true, question_id: 3 },
  { body: "Абсолютным", question_id: 3 },
  { body: "type", question_id: 4 },
  { body: "id", question_id: 4 },
  { body: "field", question_id: 4 },
  { body: "label", correct: true, question_id: 4 },
  { body: "text-size", question_id: 5 },
  { body: "font-style", question_id: 5 },
  { body: "text-style", question_id: 5 },
  { body: "font-size", correct: true, question_id: 5 },
  { body: "class", question_id: 6 },
  { body: "styles", question_id: 6 },
  { body: "style", correct: true, question_id: 6 },
  { body: "font", question_id: 6 },
  { body: "body {color: black;}", correct: true, question_id: 7 },
  { body: "{body:color=black;}", question_id: 7 },
  { body: "{body;color:black;}", question_id: 7 },
  { body: "body:color=black;", question_id: 7 },
  { body: "for, forMap, foreach, while", question_id: 8 },
  { body: "for, forMap, foreach, while, do while", question_id: 8 },
  { body: "for, while, do while, foreach", question_id: 8 },
  { body: "for, while, do while", correct: true, question_id: 8 },
  { body: "Только числа и строки", question_id: 9 },
  { body: "Строки, числа с точкой и простые числа", question_id: 9 },
  { body: "Строки, числа с точкой, простые числа и булевые выражения", correct: true, question_id: 9 },
  { body: "Rails", question_id: 10 },
  { body: "Ruby Framework", question_id: 10 },
  { body: "Ruby On Rails", correct: true, question_id: 10 },
  { body: "Ruby Web", question_id: 10 }
])

User.create([
  { name: "Виталий Черепанов", email: "vitalya123@gmail.com" },
  { name: "Анна Сидорова", email: "belka-14@mail.ru" },
  { name: "Артём Михайлов", email: "ttt777@gmail.com" }
])

UserTest.create([
  { user_id: 1, test_id: 1 },
  { user_id: 1, test_id: 2 },
  { user_id: 1, test_id: 4 },
  { user_id: 2, test_id: 1 },
  { user_id: 2, test_id: 2 },
  { user_id: 3, test_id: 1 }
])
