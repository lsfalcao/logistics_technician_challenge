require "rails_helper"

RSpec.describe LegacyOrderImports::Process, type: :service do
  let(:file) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/data_1.txt") }
  let(:legacy_order_import) { create(:legacy_order_import, file: file) }

  describe "#call" do
    let!(:service) { ::LegacyOrderImports::Process.call(legacy_order_import) }

    it { expect(User.all.count).to eq(100) }
  end
end
