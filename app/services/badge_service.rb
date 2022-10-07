class BadgeService
  attr_reader :available_badges

  def initialize()
    @available_badges = Badge.all
    @issue_badges = []
  end

  def give_badges(user)
    self.all_successful_user_tests = UsersTest.successfully_by_user(user)

    available_badges.each do |badge|
      if can_be_issued?(badge, user) && rule_worked?(badge, user)
        issue_badges << badge
      end
    end

    user.badges += issue_badges
    issue_badges
  end

  private

  attr_accessor :all_successful_user_tests, :issue_badges

  def rule_worked?(badge, user)
    rule_scope = get_rule_scope(badge.rule, user)
    return false if rule_scope.blank?

    rule_scope_ids = rule_scope.ids

    successful_tests_ids = all_successful_user_tests.pluck(:test_id)

    (rule_scope_ids - successful_tests_ids).empty?
  end

  def can_be_issued?(badge, user)
    user.badges.exclude?(badge)
  end

  def get_rule_scope(badge_rule, user)
    case badge_rule
    when "backend"
      return Test.tests_by_category_title("Backend").available
    when "frontend"
      Test.tests_by_category_title("Frontend").available
    when "level_0"
      Test.tests_by_level(0).available
    when "level_1"
      Test.tests_by_level(1).available
    when "level_2"
      Test.tests_by_level(2).available
    when "level_3"
      Test.tests_by_level(3).available
    when "level_4"
      Test.tests_by_level(4).available
    when "level_5"
      Test.tests_by_level(5).available
    when "level_6"
      Test.tests_by_level(6).available
    when "level_7"
      Test.tests_by_level(7).available
    when "level_expert"
      Test.tests_by_level_equal_or_more_then_8.available
    when "on_the_first_try"
      curr_test = all_successful_user_tests.last&.test
      same_tests = UsersTest.where(test: curr_test, user: user)
      return same_tests.length == 1 ? Test.where(id: curr_test.id) : []
    end
  end
end
