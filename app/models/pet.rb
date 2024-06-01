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

  scope :filter_by_species, ->(species) { where(species: species) if species.present? }
  scope :filter_by_age, ->(age) { where(age: age) if age.present? }
  scope :filter_by_gender, ->(gender) { where(gender: gender) if gender.present? }
  scope :filter_by_temperament, ->(temperament) { where(temperament: temperament) if temperament.present? }
  scope :filter_by_location, ->(location, distance, unit) {
    if location.present?
      near(location, distance || 15, units: unit || :mi)
    else
      where.not(adoption_status: 'adopted')
    end
  }
  scope :species_counts, -> { group(:species).count }
  scope :age_counts, -> { group(:age).count }
  scope :gender_counts, -> { group(:gender).count }
  scope :temperament_counts, -> { group(:temperament).count }
end
