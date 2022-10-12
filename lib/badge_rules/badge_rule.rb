class BadgeRule
  CONDITIONS = {
    equal: { value: "=", title: I18n.t("badge_rules.conditions.equal") },
    more: { value: ">", title: I18n.t("badge_rules.conditions.more") },
    less: { value: "<", title: I18n.t("badge_rules.conditions.less") },
    more_or_equal: { value: ">=", title: I18n.t("badge_rules.conditions.more_or_equal") },
    less_or_equal: { value: "<=", title: I18n.t("badge_rules.conditions.less_or_equal") },
  }

  def initialize(badge, options = {})
    @badge, @options = badge, options
  end

  def self.rule_name
    rule_name = self.name.underscore
    rule_name.slice!("badge_rule_")
    rule_name
  end

  def self.class_by(rule_name, options = {})
    "badge_rule_#{rule_name}".camelize.constantize
  end

  def self.rule_name_title
    I18n.t("badge_rules.names.#{self.rule_name}")
  end

  def self.get_scope(badge, options)
    raise NotImplementedError, "#{self.name} has not implemented method '#{__method__}'"
  end
end
