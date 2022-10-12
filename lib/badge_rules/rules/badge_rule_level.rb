class BadgeRuleLevel < BadgeRule
  def self.get_scope(badge, options = {})
    Test.where("level #{badge.query_condition} ?", badge.rule_param).available
  end
end
