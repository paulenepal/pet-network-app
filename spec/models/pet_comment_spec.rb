require 'rails_helper'

RSpec.describe PetComment, type: :model do
  describe 'associations' do
    it 'belongs to pet' do
      association = described_class.reflect_on_association(:pet)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'validates presence of comment_text' do
      comment = PetComment.new(comment_text: nil)
      comment.valid?
      expect(comment.errors[:comment_text]).to include("can't be blank")
    end
  end
end
