class Answer < ApplicationRecord
  belongs_to :question

  scope :right_answers, -> { where(correct: true) }

  validates :body, presence: true

  validate :validate_answers_count

  private

  def validate_answers_count
    return if persisted?
    if question.answers.count >= 4
      errors.add(:base, "You cannot create more than 4 answers for question")
    end
  end
end
