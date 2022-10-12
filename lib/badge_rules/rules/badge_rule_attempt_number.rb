class BadgeRuleAttemptNumber < BadgeRule
  def self.get_scope(badge, options)
    same_tests = UsersTest.where(test: options[:test], user: options[:user])
    same_tests.length == badge.rule_param.to_i ? Test.where(id: options[:test].id) : []
  end
end
