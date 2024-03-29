module ApplicationHelper
  ALERT_TYPES = {
    notice: 'secondary',
    alert: 'danger'
  }.freeze

  def current_year
    Date.today.year
  end

  def github_url(link_title, author, repo, options = {})
    link_to link_title, "https://github.com/#{author}/#{repo}", options
  end

  def boolean_readable(bool)
    bool ? t("common.yes") : t("common.no")
  end

  def flash_block
    flash.map do |key, message|
      ending_alert_class_name = ALERT_TYPES[key.to_sym] || key
      content_tag :div, message.html_safe, class: "alert alert-#{ending_alert_class_name} mb-0" if flash[key]
    end.join.html_safe
  end

  def admin_email
    Admin.first.email
  end
end

