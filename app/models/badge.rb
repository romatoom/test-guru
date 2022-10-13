class Badge < ApplicationRecord
  has_many :users_badges, dependent: :destroy
  has_many :users, through: :users_badges

  validates :title, :description, :url, :rule_name, :rule_condition, :rule_param, presence: true
  validates :title, uniqueness: true

  def query_condition
    BadgeRule::CONDITIONS[rule_condition.to_sym][:value]
  end

  def can_be_issued?(user)
    user.badges.exclude?(self)
  end
end
