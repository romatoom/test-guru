module QuestionsHelper
  def question_header(question)
    return "Создание вопроса для теста \"#{question.test.title}\" с уровнем сложности #{question.test.level}" if question.new_record?

    "Редактирование вопроса для теста \"#{question.test.title}\" с уровнем сложности #{question.test.level}"
  end
end
