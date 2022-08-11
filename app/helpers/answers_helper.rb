module AnswersHelper
  def answer_header(answer)
    if answer.new_record?
      "Создание ответа на вопрос \"#{answer.question.body}\""
    else
      "Редактирование варианта ответа на вопрос \"#{answer.question.body}\""
    end
  end
end
