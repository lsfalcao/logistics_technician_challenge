require "rails_helper"

RSpec.describe User, type: :model do
  describe "Factory" do
    let(:user) { create(:user) }

    it { expect(user).to be_valid }
  end

  describe "associantions" do
    it { is_expected.to have_many(:orders).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
