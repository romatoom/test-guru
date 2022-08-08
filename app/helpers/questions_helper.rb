module QuestionsHelper
  def question_header(question)
    if question.new_record?
      "Создание вопроса для теста \"#{question.test.title}\" с уровнем сложности #{question.test.level}"
    else
      "Редактирование вопроса для теста \"#{question.test.title}\" с уровнем сложности #{question.test.level}"
    end
  end
end
