require 'rails_helper'

RSpec.describe Adopter, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many favorites' do
      association = described_class.reflect_on_association(:favorites)
      expect(association.macro).to eq :has_many
    end

    it 'has many adoption_applications' do
      association = described_class.reflect_on_association(:adoption_applications)
      expect(association.macro).to eq :has_many
    end
  end

  describe 'validations' do
    it 'validates presence of first_name' do
      adopter = Adopter.new(first_name: nil)
      adopter.valid?
      expect(adopter.errors[:first_name]).to include("can't be blank")
    end

    it 'validates presence of last_name' do
      adopter = Adopter.new(last_name: nil)
      adopter.valid?
      expect(adopter.errors[:last_name]).to include("can't be blank")
    end
  end
end
