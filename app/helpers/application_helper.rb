module ApplicationHelper
  def current_year
    Date.today.year
  end

  def github_url(link_title, author, repo, options = {})
    link_to link_title, "https://github.com/#{author}/#{repo}", options
  end

  def boolean_to_yes_no(bool)
    bool ? "Да" : "Нет"
  end
end
