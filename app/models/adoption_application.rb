class AdoptionApplication < ApplicationRecord
  enum status: { submitted: 0, approved: 1, rejected: 2 }

  belongs_to :adopter, class_name: 'User', foreign_key: :adopter_id
  belongs_to :pet

  validates :status, presence: true
  validates :application_date, presence: true

  scope :approved, -> { where(status: :approved) }
  scope :submitted, -> { where(status: :submitted) }
  scope :rejected, -> { where(status: :rejected) }
end
