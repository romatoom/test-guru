class BadgeRuleLevel < BadgeRule
  def self.worked?(badge, options = {})
    user = options[:user]
    return false if user.nil?

    rule_scope = Test.where("level #{badge.query_condition} ?", badge.rule_param).available
    return false if rule_scope.blank?

    rule_scope_ids = rule_scope.ids

    user = options[:user]

    successful_tests_ids = user.users_tests.where(successfully: true).pluck(:test_id)

    (rule_scope_ids - successful_tests_ids).empty?
  end
end
