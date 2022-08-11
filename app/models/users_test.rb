class UsersTest < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_сurrent_question

  MIN_PERCENT_SUCCESS_PASSED_TEST = 85

  def accept!(answers_ids)
    if correct_all_answers?(answers_ids)
      self.correct_answers += 1
    end

    save!
  end

  def finished?
    current_question.nil?
  end

  def questions_count
    test.questions.count
  end

  def result_in_persent
    (correct_answers.to_f / questions_count * 100).round
  end

  def success?
    result_in_persent >= MIN_PERCENT_SUCCESS_PASSED_TEST
  end

  private

  def correct_all_answers?(answers_ids)
    current_question.answers.right_answers.ids.sort == (answers_ids || []).map(&:to_i).sort
  end

  def before_validation_set_сurrent_question
    return unless test.present?

    self.current_question = current_question.nil? ? test.questions.first : current_question.next
  end
end
