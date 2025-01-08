require "rails_helper"

RSpec.describe OrderProduct, type: :model do
  describe "Factory" do
    let(:order_product) { create(:order_product) }

    it { expect(order_product).to be_valid }
  end

  describe "associantions" do
    it { is_expected.to belong_to(:order) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_presence_of(:product_id) }
  end
end
