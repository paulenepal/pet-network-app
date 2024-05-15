class User < ApplicationRecord
  enum role: { admin: 0, shelter: 1, adopter: 2 }

  has_one :shelter
  has_one :adopter
  has_many :pet_comments
  has_many :adoption_applications, foreign_key: :adopter_id

  validates :username, presence: true
  validates :location, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
