# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def add_answers_for_question(wrong_answers, right_answer, question)
  question.answers.create!(body: right_answer, correct: true)
  wrong_answers.each { |answer| question.answers.create!(body: answer) }
end

puts "Create seeds..."

category = Category.create!(title: "Frontend")

adminPassword = "Admin123"

admin = Admin.new(
  first_name: "Алексей",
  last_name: "Алексеев",
  email: "first_admin@gmail.com",
  password: adminPassword,
  password_confirmation: adminPassword
)
admin.skip_confirmation!
admin.save!

test = category.tests.create!(title: "HTML", author_id: admin.id, published: true)

question = test.questions.create!(body: "Как оформляется комментарий в HTML?")
wrong_answers = ["/* комментарий */", "// комментарий"]
add_answers_for_question(wrong_answers, "<!—- комментарий -->", question)

question = test.questions.create!(body: "С помощью какого атрибута можно задать текст для картинки, который будет отображен, если её не удастся загрузить?")
add_answers_for_question(%w(popup title caption), "alt", question)

question = test.questions.create!(body: "Каким является следующий адрес ссылки: ./pages/page2.html?")
add_answers_for_question(["Абсолютным"], "Относительным", question)

question = test.questions.create!(body: "С помощью какого тега нужно задавать подписи к полям формы?")
add_answers_for_question(%w(type id field), "label", question)

test = category.tests.create!(title: "CSS", author_id: admin.id, published: true)

question = test.questions.create!(body: "Какое свойство CSS определяет размер текста?")
add_answers_for_question(%w(text-size font-style text-style), "font-size", question)

question = test.questions.create!(body: "Какой атрибут используется для определения встроенных стилей?")
add_answers_for_question(%w(class styles font), "style", question)

question = test.questions.create!(body: "Каков правильный синтаксис CSS?")
wrong_answers = ["{body:color=black;}", "{body;color:black;}", "body:color=black;"]
add_answers_for_question(wrong_answers, "body {color: black;}", question)

test = category.tests.create!(title: "Javascript", author_id: admin.id, published: true)

question = test.questions.create!(body: "Какие циклы есть в языке JavaScript?")
wrong_answers = [
  "for, forMap, foreach, while",
  "for, forMap, foreach, while, do while",
  "for, while, do while, foreach"
]
add_answers_for_question(wrong_answers, "for, while, do while", question)

question = test.questions.create!(body: "Какие значения можно хранить в переменных?")
wrong_answers = ["Только числа и строки", "Строки, числа с точкой и простые числа"]
add_answers_for_question(wrong_answers, "Строки, числа с точкой, простые числа и булевые выражения", question)

# # #

category = Category.create!(title: "Backend")

test = category.tests.create!(title: "Ruby", level: 1, author_id: admin.id, published: true)

question = test.questions.create!(body: "Название самого популярного фреймворка Ruby?")

wrong_answers = ["Rails", "Ruby Framework", "Ruby Web"]
add_answers_for_question(wrong_answers, "Ruby On Rails", question)

test = category.tests.create!(title: "Ruby On Rails", level: 2, author_id: admin.id)

# # #

test_html_0 = Test.find_by(title: "HTML", level: 0)
test_css_0 = Test.find_by(title: "CSS", level: 0)
test_js_0 = Test.find_by(title: "Javascript", level: 0)
test_ruby_1 = Test.find_by(title: "Ruby", level: 1)
test_rails_2 = Test.find_by(title: "Ruby On Rails", level: 2)

userPassword = "User123"

user = User.new(
  first_name: "Виталий",
  last_name: "Черепанов",
  email: "vitalya123@gmail.com",
  password: userPassword,
  password_confirmation: userPassword
)
user.skip_confirmation!
user.save!

user.tests.push(test_html_0)
user.tests.push(test_css_0)
user.tests.push(test_ruby_1)

user = User.new(
  first_name: "Анна",
  last_name: "Сидорова",
  email: "belka-14@mail.ru",
  password: userPassword,
  password_confirmation: userPassword
)
user.skip_confirmation!
user.save!

user.tests.push(test_html_0)
user.tests.push(test_css_0)

user = User.new(
  first_name: "Артём",
  last_name: "Михайлов",
  email: "ttt777@gmail.com",
  password: userPassword,
  password_confirmation: userPassword
)
user.skip_confirmation!
user.save!

user.tests.push(test_html_0)

# Create default badges list
badges_path = Rails.application.config.badges_path

available_badges = []

badge_levels = (0..7).map do |level|
  {
    title: "Покоритель уровней - #{level}",
    description: "За успешное прохождение всех тестов с уровнем сложности #{level}",
    filename: "level-#{level}.png"
  }
end

badge_levels << {
  title: "Покоритель уровней - EXPERT",
  description: "За успешное прохождение всех тестов с уровнем сложности 8 и выше",
  filename: "level-expert.png"
}

available_badges += badge_levels

available_badges << {
  title: "Backend-мастер",
  description: "За успешное прохождение всех тестов категории Backend",
  filename: "backend.png"
}

available_badges << {
  title: "Frontend-мастер",
  description: "За успешное прохождение всех тестов категории Frontend",
  filename: "frontend.png"
}

available_badges.each do |b|
  badge = Badge.new(
    title: b[:title],
    description: b[:description],
    url: "#{badges_path}/#{b[:filename]}"
  )
  badge.save
end

user_with_badges = User.where.not(type: "Admin").first
user_with_badges.badges << Badge.find_by(title: "Frontend-мастер")
user_with_badges.badges << Badge.find_by(title: "Покоритель уровней - 0")
user_with_badges.badges << Badge.find_by(title: "Покоритель уровней - 1")

puts "Seeds has been created successfully!"
