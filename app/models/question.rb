class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy
  has_many :users_tests, foreign_key: "current_question_id", dependent: :destroy

  validates :body, presence: true

  def position
    questions_ids_in_test = self.test.questions.pluck(:id).sort
    questions_ids_in_test.find_index(self.id) + 1
  end
end
