class UsersTest < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_validation :before_validation_set_current_question, on: :update

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

  private

  def correct_all_answers?(answers_ids = [])
    answers_ids = [] if answers_ids.nil?
    current_question.answers.right_answers.ids.sort == answers_ids.map(&:to_i).sort
  end

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def before_validation_set_current_question
    self.current_question = test.questions.order(:id).where("id > ?", current_question.id).first
  end
end
