class Shelter < ApplicationRecord
  belongs_to :user
  has_many :pets
  has_many :adoption_applications, through: :pets

  validates :name, presence: true
  validates :address, presence: true
end
