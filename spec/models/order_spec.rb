require "rails_helper"

RSpec.describe Order, type: :model do
  describe "Factory" do
    let(:order) { create(:order) }

    it { expect(order).to be_valid }
  end

  describe "associantions" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:order_products).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:date) }
  end
end
