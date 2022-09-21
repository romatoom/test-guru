module GistsHelper
  MAX_LENGHT_QUESTION_BODY = 25.freeze

  def question_link(question)
    link_text = question.body.truncate(MAX_LENGHT_QUESTION_BODY)

    link_to link_text, admin_question_path(question), target: "_blank"
  end

  def gist_link(gist)
    link_to gist.gist_hash, gist.link_url, target: "_blank"
  end
end
