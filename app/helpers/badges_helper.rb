module BadgesHelper
  def badge_header(badge)
    if badge.new_record?
      t(".create_badge")
    else
      t(".edit_badge")
    end
  end

  def badge_url(badge)
    "#{Rails.application.config.badges_path}/#{badge.url}"
  end
end
