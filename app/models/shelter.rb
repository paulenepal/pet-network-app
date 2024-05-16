class Shelter < ApplicationRecord
  belongs_to :user
  has_many :pets

  validates :name, presence: true
  validates :address, presence: true
end
