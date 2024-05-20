require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has one shelter' do
      association = described_class.reflect_on_association(:shelter)
      expect(association.macro).to eq :has_one
    end

    it 'has one adopter' do
      association = described_class.reflect_on_association(:adopter)
      expect(association.macro).to eq :has_one
    end

    it 'has many pet_comments' do
      association = described_class.reflect_on_association(:pet_comments)
      expect(association.macro).to eq :has_many
    end

    it 'has many adoption_applications with foreign key adopter_id' do
      association = described_class.reflect_on_association(:adoption_applications)
      expect(association.macro).to eq :has_many
      expect(association.options[:foreign_key]).to eq(:adopter_id)
    end
  end

  describe 'validations' do
    it 'validates presence of username' do
      user = User.new(username: nil)
      user.valid?
      expect(user.errors[:username]).to include("can't be blank")
    end

    it 'validates presence of location' do
      user = User.new(location: nil)
      user.valid?
      expect(user.errors[:location]).to include("can't be blank")
    end
  end
end
