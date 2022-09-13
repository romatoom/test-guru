module QuestionsHelper
  def question_header(question)
    if question.new_record?
      t(".create_question", test_title: question.test.title, test_level: question.test.level)
    else
      t(".edit_question", test_title: question.test.title, test_level: question.test.level)
    end
  end
end
