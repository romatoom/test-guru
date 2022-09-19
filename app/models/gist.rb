class Gist < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :link_url, presence: true

  def gist_hash
    link_url.split('/').last
  end
end
