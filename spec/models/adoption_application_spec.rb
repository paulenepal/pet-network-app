require 'rails_helper'

RSpec.describe AdoptionApplication, type: :model do
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
    it 'validates presence of status' do
      application = AdoptionApplication.new(status: nil)
      application.valid?
      expect(application.errors[:status]).to include("can't be blank")
    end

    it 'validates presence of application_date' do
      application = AdoptionApplication.new(application_date: nil)
      application.valid?
      expect(application.errors[:application_date]).to include("can't be blank")
    end
  end
end
