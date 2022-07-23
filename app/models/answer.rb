class Answer < ApplicationRecord
  belongs_to :question

  scope :right_answers, -> { where(correct: true) }

  validates :body, presence: true

  validate :validate_count_on_create, on: :create
  validate :validate_count_on_update, on: :update

  scope :count_with_question_id, ->(question_id) { where(question_id: question_id).count }

  private

  def validate_count_on_create
    if Answer.count_with_question_id(question_id) >= 4
      errors.add(:question_id, "You cannot create more than 4 answers for question")
    end
  end

  def validate_count_on_update
    unless (1..4).include?(Answer.count_with_question_id(question_id))
      errors.add(:question_id, "The number of answers for question should be from 1 to 4")
    end
  end
end
