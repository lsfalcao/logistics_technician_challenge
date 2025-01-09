require "rails_helper"

RSpec.describe LegacyOrderImport, type: :model do
  describe "Factory" do
    let(:legacy_order_import) { create(:legacy_order_import) }

    it { expect(legacy_order_import).to be_valid }
  end

  describe "associantions" do
    it { is_expected.to belong_to(:client) }
  end
end
