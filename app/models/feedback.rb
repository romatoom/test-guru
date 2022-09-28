class Feedback
  attr_reader :theme, :text

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  validates :theme, presence: true
  validates :text, presence: true

  def initialize(attributes = {})
    @theme = attributes[:theme]
    @text = attributes[:text]
  end
end
