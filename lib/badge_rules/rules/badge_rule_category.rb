class BadgeRuleCategory < BadgeRule
  def self.get_scope(badge, options = {})
    Test.tests_by_category_title(badge.rule_param).available
  end
end
