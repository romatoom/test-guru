module ApplicationHelper
  def current_year
    Date.today.year
  end

  def github_url(link_title, author, repo, options = {})
    link_to link_title, "https://github.com/#{author}/#{repo}", options
  end

  def boolean_readable(bool)
    bool ? "Да" : "Нет"
  end

  def flash_block
    flash.each do |key, message|
      return content_tag :p, message, class: "flash #{key.to_s}" if flash[key]
    end

    return
  end
end
