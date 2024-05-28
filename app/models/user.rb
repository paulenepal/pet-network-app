class User < ApplicationRecord
  enum role: { admin: 0, shelter: 1, adopter: 2 }

  has_one :shelter, dependent: :destroy
  has_one :adopter, dependent: :destroy
  has_many :pet_comments, dependent: :destroy
  has_many :adoption_applications, foreign_key: :adopter_id, dependent: :destroy
  has_many :favorites, dependent: :destroy

  accepts_nested_attributes_for :shelter
  accepts_nested_attributes_for :adopter

  validates :username, presence: true
  validates :location, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def active_for_authentication?
    super && approved?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def inactive_message
    approved? ? super : :not_approved
  end

  private

  def block_from_invitation?
    false
  end
end
