class Badge < ApplicationRecord
  has_many :users_badges, dependent: :destroy
  has_many :users, through: :users_badges

  validates :title, :description, :url, :rule_name, :rule_condition, :rule_param, presence: true

  RULE_CONDITIONS = {
    equal: { value: "=", title: I18n.t("badge_rules.conditions.equal") },
    more: { value: ">", title: I18n.t("badge_rules.conditions.more") },
    less: { value: "<", title: I18n.t("badge_rules.conditions.less") },
    more_or_equal: { value: ">=", title: I18n.t("badge_rules.conditions.more_or_equal") },
    less_or_equal: { value: "<=", title: I18n.t("badge_rules.conditions.less_or_equal") },
  }

  RULE_NAMES = {
    category: {
      title: I18n.t("badge_rules.names.category")
      # available_conditions: [:equal]
    },

    level: {
      title: I18n.t("badge_rules.names.level")
      # available_conditions: %i(equal more less more_or_equal less_or_equal)
    },

    attempt_number: {
      title: I18n.t("badge_rules.names.attempt_number")
      # available_conditions: [:equal]
    }
  }

  def self.rule_name_label(rule_name)
    I18n.t("badge_rules.names.#{rule_name.to_s}")
  end

  def self.rule_name_labels
    RULE_NAMES.map { |rule_name, v| [Badge.rule_name_label(rule_name), rule_name.to_s] }
  end

  def self.rule_condition_label(rule_condition)
    I18n.t("badge_rules.conditions.#{rule_condition.to_s}")
  end

  def self.rule_condition_labels
    RULE_CONDITIONS.map { |rule_condition, v| [Badge.rule_condition_label(rule_condition), rule_condition.to_s]}
  end

  def query_condition
    RULE_CONDITIONS[rule_condition.to_sym][:value]
  end

  def get_rule_scope(options)
    user = options[:user]
    test = options[:test]

    if rule_name == 'level'
      return Test.where("level #{query_condition} ?", rule_param).available
    end

    if rule_name == 'category'
      return Test.tests_by_category_title(rule_param).available
    end

    if rule_name == 'attempt_number'
      same_tests = UsersTest.where(test: test, user: user)
      same_tests.length == rule_param.to_i ? Test.where(id: test.id) : []
    end
  end

  def can_be_issued?(user)
    user.badges.exclude?(self)
  end
end
