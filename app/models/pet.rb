class Pet < ApplicationRecord
  enum adoption_status: { available: 0, pending: 1, adopted: 2 }

  belongs_to :shelter
  has_many :favorites
  has_many :adoption_applications
  has_many :pet_comments

  validates :name, presence: true
  validates :species, presence: true
end
