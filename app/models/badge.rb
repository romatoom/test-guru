class Badge < ApplicationRecord
  has_many :users_badges, dependent: :destroy
  has_many :users, through: :users_badges

  BADGE_RULES = %i(backend frontend level_0 level_1 level_2 level_3 level_4 level_5
    level_6 level_7 level_expert on_the_first_try).freeze

  def self.badge_rule_label(badge_rule)
    I18n.t("badge_rules.#{badge_rule.to_s}")
  end
end
