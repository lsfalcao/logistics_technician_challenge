require "rails_helper"

RSpec.describe Client, type: :model do
  describe "Factory" do
    let(:client) { create(:client) }

    it { expect(client).to be_valid }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_many(:legacy_order_imports).dependent(:destroy) }
  end
end
