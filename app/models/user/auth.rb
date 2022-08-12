module User::Auth
  extend ActiveSupport::Concern

  attr_reader :password
  attr_writer :password_confirmation

  included do
    validates :email, presence: true, uniqueness: true
    validates :name, presence: true
    validates :password, presence: true, if: ->(user) { user.password_digest.blank? }
    validates :password, confirmation: true
  end

  def password=(password_string)
    if password_string.nil?
      self.password_digest = nil
    elsif password_string.present?
      @password = password_string
      self.password_digest = digest(password_string)
    end
  end

  def autenticate(password_string)
    digest(password_string) == password_digest ? self : false
  end

  private

  def digest(password_string)
    Digest::SHA1.hexdigest(password_string)
  end
end
