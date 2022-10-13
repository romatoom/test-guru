class BadgeRuleAttemptNumber < BadgeRule
  def self.worked?(badge, options)
    test = options[:test]
    user = options[:user]
    return false if test.nil? || user.nil?

    same_tests = UsersTest.where(test: test, user: user)
    same_tests.length == badge.rule_param.to_i
  end
end
