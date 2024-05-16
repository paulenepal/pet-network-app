require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'associations' do
    it 'belongs to adopter' do
      association = described_class.reflect_on_association(:adopter)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to pet' do
      association = described_class.reflect_on_association(:pet)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'validates presence of user_id' do
      favorite = Favorite.new(user_id: nil)
      favorite.valid?
      expect(favorite.errors[:user_id]).to include("can't be blank")
    end

    it 'validates presence of pet_id' do
      favorite = Favorite.new(pet_id: nil)
      favorite.valid?
      expect(favorite.errors[:pet_id]).to include("can't be blank")
    end
  end
end
