module QuestionsHelper
  def current_year
    Date.today.year
  end

  def github_url(author, repo)
    "https://github.com/#{author}/#{repo}"
  end

  def question_header(test)
    return "Создание вопроса для теста \"#{test.title}\" с уровнем сложности #{test.level}" if action_name == "new"

    "Редактирование вопроса для теста \"#{test.title}\" с уровнем сложности #{test.level}"
  end
end
