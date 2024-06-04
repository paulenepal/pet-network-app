class Adopter < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :adoption_applications

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
    end
end
