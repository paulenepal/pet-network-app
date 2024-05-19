require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "invite_shelter" do
    let(:user) { create(:user) }
    let(:shelter_name) { "Example Shelter" }
    let(:mail) { UserMailer.invite_shelter(user, shelter_name) }

    it "renders the headers" do
      expect(mail.subject).to eq("Invitation to Join Our Platform")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["no-reply@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hello")
      expect(mail.body.encoded).to match(shelter_name)
    end
  end

end
