module TestsHelper
  def test_header(test)
    if test.new_record?
      "Создание нового теста"
    else
      "Редактирование теста \"#{test.title}\""
    end
  end
end