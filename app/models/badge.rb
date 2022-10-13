class Badge < ApplicationRecord
  has_many :users_badges, dependent: :destroy
  has_many :users, through: :users_badges

  validates :title, :description, :url, :rule_name, :rule_condition, :rule_param, presence: true

  def query_condition
    BadgeRule::CONDITIONS[rule_condition.to_sym][:value]
  end

  def can_be_issued?(user)
    user.badges.exclude?(self)
  end

  def rule_worked?(options)
    test = options[:test]
    user = options[:user]

    BadgeRule.class_by(badge.rule_name).check(badge, { user: user, test: test })
  end
end
