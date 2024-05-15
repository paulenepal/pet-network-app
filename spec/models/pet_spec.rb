require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'associations' do
    it 'belongs to shelter' do
      association = described_class.reflect_on_association(:shelter)
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

    it 'has many pet_comments' do
      association = described_class.reflect_on_association(:pet_comments)
      expect(association.macro).to eq :has_many
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      pet = Pet.new(name: nil)
      pet.valid?
      expect(pet.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of species' do
      pet = Pet.new(species: nil)
      pet.valid?
      expect(pet.errors[:species]).to include("can't be blank")
    end
  end
end
