class PetComment < ApplicationRecord
  belongs_to :pet
  belongs_to :user

  validates :comment_text, presence: true
end
