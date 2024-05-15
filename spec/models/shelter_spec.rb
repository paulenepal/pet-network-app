require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many pets' do
      association = described_class.reflect_on_association(:pets)
      expect(association.macro).to eq :has_many
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      shelter = Shelter.new(name: nil)
      shelter.valid?
      expect(shelter.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of address' do
      shelter = Shelter.new(address: nil)
      shelter.valid?
      expect(shelter.errors[:address]).to include("can't be blank")
    end
  end
end
