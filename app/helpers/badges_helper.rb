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

  def rule_condition_labels
    BadgeRule::CONDITIONS.map do |rule_condition, v|
      [I18n.t("badge_rules.conditions.#{rule_condition.to_s}"), rule_condition.to_s]
    end
  end

  def rule_name_labels
    BadgeService.rule_classes.map do |rule_class|
      [rule_class.rule_name_title, rule_class.rule_name]
    end
  end
end
