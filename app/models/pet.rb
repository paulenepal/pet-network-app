class Pet < ApplicationRecord
  geocoded_by :location
  after_validation :geocode

  enum adoption_status: { available: 0, pending: 1, adopted: 2 }

  belongs_to :shelter
  has_many :favorites
  has_many :favorited_by_users, through: :favorites, source: :use
  has_many :adoption_applications
  has_many :pet_comments

  validates :name, presence: true
  validates :species, presence: true

  has_many_attached :photos
  #ActiveStorage requires its own table to manage file attachments (in our case, pet photos)
  #This is isolated to the ActiveStorage system, so there should be no impact with our existing tables
end
