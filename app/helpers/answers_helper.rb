module AnswersHelper
  def answer_header(answer)
    if answer.new_record?
      t(".create_answer", answer_text: answer.question.body)
    else
      t(".edit_answer", answer_text: answer.question.body)
    end
  end
end
