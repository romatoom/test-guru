class Answer < ApplicationRecord
  belongs_to :question

  scope :right_answers, -> { where(correct: true) }

  validates :body, presence: true

  validate :validate_count_for_one_test

  private

  def validate_count_for_one_test
    answers_count = Answer.where(question_id: question_id).count
    errors.add(:question_id, "The number of questions in test should be from 1 to 4") if answers_count >= 4
  end
end
