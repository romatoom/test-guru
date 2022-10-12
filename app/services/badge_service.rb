class BadgeService
  RULE_FOLDER = "lib/badge_rules/rules".freeze

  def self.rule_classes
    @rules ||= Dir.entries(RULE_FOLDER)
      .filter { |f| !File.directory? f }
      .map { |f| File.basename(f, ".rb")
      .camelize
      .constantize
    }
  end

  attr_reader :available_badges

  def initialize(user_test)
    @available_badges = Badge.all
    @issue_badges = []
    @user = user_test.user
    @test = user_test.test
  end

  def give_badges
    self.all_successful_user_tests = user.users_tests.where(successfully: true)

    available_badges.each do |badge|
      if badge.can_be_issued?(user) && rule_worked?(badge)
        issue_badges << badge
      end
    end

    user.badges += issue_badges
    issue_badges
  end

  private

  attr_accessor :all_successful_user_tests, :issue_badges
  attr_reader :user, :test

  def rule_worked?(badge)
    rule_scope = BadgeRule.class_by(badge.rule_name)
      .get_scope(badge, { user: user, test: test })

    return false if rule_scope.blank?

    rule_scope_ids = rule_scope.ids

    successful_tests_ids = all_successful_user_tests.pluck(:test_id)

    (rule_scope_ids - successful_tests_ids).empty?
  end
end
