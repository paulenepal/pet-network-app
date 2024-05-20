class Favorite < ApplicationRecord
  belongs_to :adopter, class_name: 'User', foreign_key: :user_id
  belongs_to :pet

  validates :user_id, presence: true
  validates :pet_id, presence: true
end
