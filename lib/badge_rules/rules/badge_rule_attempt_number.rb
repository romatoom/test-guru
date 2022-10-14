class BadgeRuleAttemptNumber < BadgeRule
  def self.worked?(badge, user_test)
    test = user_test.test
    user = user_test.user
    return false if test.nil? || user.nil?

    same_tests = UsersTest.where(test: test, user: user)
    same_tests.length == badge.rule_param.to_i && user_test.success?
  end
end
