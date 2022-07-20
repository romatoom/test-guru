# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def add_answers_for_question(wrong_answers, right_answer, question_id)
  Answer.create(body: right_answer, correct: true, question_id: question_id)
  wrong_answers.each { |answer| Answer.create(body: answer, question_id: question_id) }
end

category = Category.create(title: "Frontend")

test = Test.create(title: "HTML", category_id: category.id)

question = Question.create(body: "Как оформляется комментарий в HTML?", test_id: test.id)
wrong_answers = ["/* комментарий */", "// комментарий"]
add_answers_for_question(wrong_answers, "<!—- комментарий -->", question.id)

question = Question.create(
  body: "С помощью какого атрибута можно задать текст для картинки, который будет отображен, если её не удастся загрузить?",
  test_id: test.id
)
add_answers_for_question(%w(popup title caption), "alt", question.id)

question = Question.create(body: "Каким является следующий адрес ссылки: ./pages/page2.html?", test_id: test.id)
add_answers_for_question(["Абсолютным"], "Относительным", question.id)

question = Question.create(body: "С помощью какого тега нужно задавать подписи к полям формы?", test_id: test.id)
add_answers_for_question(%w(type id field), "label", question.id)

test = Test.create(title: "CSS", category_id: category.id)

question = Question.create(body: "Какое свойство CSS определяет размер текста?", test_id: test.id)
add_answers_for_question(%w(text-size font-style text-style), "font-size", question.id)

question = Question.create(body: "Какой атрибут используется для определения встроенных стилей?", test_id: test.id)
add_answers_for_question(%w(class styles font), "style", question.id)

question = Question.create(body: "Каков правильный синтаксис CSS?", test_id: test.id)
wrong_answers = ["{body:color=black;}", "{body;color:black;}", "body:color=black;"]
add_answers_for_question(wrong_answers, "body {color: black;}", question.id)

test = Test.create(title: "Javascript", category_id: category.id)

question = Question.create(body: "Какие циклы есть в языке JavaScript?", test_id: test.id)
wrong_answers = [
  "for, forMap, foreach, while",
  "for, forMap, foreach, while, do while",
  "for, while, do while, foreach"
]
add_answers_for_question(wrong_answers, "for, while, do while", question.id)

question = Question.create(body: "Какие значения можно хранить в переменных?", test_id: test.id)
wrong_answers = ["Только числа и строки", "Строки, числа с точкой и простые числа"]
add_answers_for_question(wrong_answers, "Строки, числа с точкой, простые числа и булевые выражения", question.id)

# # #

category = Category.create(title: "Backend")

test = Test.create(title: "Ruby", level: 1, category_id: category.id)

question = Question.create(body: "Как называется самый популярный фреймворк языка Ruby для веба?", test_id: test.id)
Answer.create(body: "Rails", question_id: question.id)
Answer.create(body: "Ruby Framework", question_id: question.id)
Answer.create(body: "Ruby On Rails", correct: true, question_id: question.id)
Answer.create(body: "Ruby Web", question_id: question.id)

test = Test.create(title: "Ruby On Rails", level: 2, category_id: category.id)

# # #

test_html_0 = Test.find_by(title: "HTML", level: 0)
test_css_0 = Test.find_by(title: "CSS", level: 0)
test_js_0 = Test.find_by(title: "Javascript", level: 0)
test_ruby_1 = Test.find_by(title: "Ruby", level: 1)
test_rails_2 = Test.find_by(title: "Ruby On Rails", level: 2)

user = User.create(name: "Виталий Черепанов", email: "vitalya123@gmail.com")
UserTest.create([
  { user_id: user.id, test_id: test_html_0.id },
  { user_id: user.id, test_id: test_css_0.id },
  { user_id: user.id, test_id: test_ruby_1.id }
])

user = User.create(name: "Анна Сидорова", email: "belka-14@mail.ru")
UserTest.create([
  { user_id: user.id, test_id: test_html_0.id },
  { user_id: user.id, test_id: test_css_0.id }
])

user = User.create(name: "Артём Михайлов", email: "ttt777@gmail.com")
UserTest.create(user_id: user.id, test_id: test_html_0.id)
