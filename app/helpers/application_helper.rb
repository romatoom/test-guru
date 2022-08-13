module ApplicationHelper
  FLASH_BLOCK_KEYS = %i(info success warning danger).freeze

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
    FLASH_BLOCK_KEYS.each do |key|
      puts key, flash[key]
      return content_tag :p, flash[key], class: "flash #{key.to_s}" if flash[key]
    end

    return
  end
end
