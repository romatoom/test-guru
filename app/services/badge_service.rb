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
    available_badges.each do |badge|
      if badge.can_be_issued?(user) && bage_rule_worked?(badge)
        issue_badges << badge
      end
    end

    user.badges += issue_badges
    issue_badges
  end

  private

  def bage_rule_worked?(badge)
    BadgeRule.class_by(badge.rule_name).worked?(badge, { user: user, test: test })
  end

  attr_accessor :issue_badges
  attr_reader :user, :test
end
