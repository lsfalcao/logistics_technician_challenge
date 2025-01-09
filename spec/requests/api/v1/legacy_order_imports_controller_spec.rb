require "rails_helper"

RSpec.describe "Api::V1::LegacyOrderImportsController", type: :request do
  let!(:client) { create(:client) }
  let!(:legacy_order_import) { create(:legacy_order_import) }
  let(:valid_attributes) { {file: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, "/public/desafio/data_1.txt")))} }
  let(:invalid_attributes) { {file: ""} }

  before do
    sign_in client
  end

  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_legacy_order_imports_url

      expect(response).to be_successful
      expect(response.body).to include(legacy_order_import.id.to_s)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get api_v1_legacy_order_import_url(legacy_order_import)

      expect(response).to be_successful
      expect(response.body).to include(legacy_order_import.id.to_s)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new LegacyOrderImport" do
        expect {
          post api_v1_legacy_order_imports_url, params: valid_attributes
        }.to change(LegacyOrderImport, :count).by(1)
        legacy_order_import = LegacyOrderImport.last
        expect(legacy_order_import.file.filename.to_s).to eq("data_1.txt")
      end
    end

    context "with invalid parameters" do
      it "does not create a new LegacyOrderImport" do
        expect {
          post api_v1_legacy_order_imports_url, params: invalid_attributes
        }.to change(LegacyOrderImport, :count).by(0)
      end

      it "renders a unprocessable_entity response" do
        post api_v1_legacy_order_imports_url, params: invalid_attributes
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested legacy_order_import" do
      legacy_order_import_1 = create(:legacy_order_import)

      expect {
        delete api_v1_legacy_order_import_url(legacy_order_import_1)
      }.to change(LegacyOrderImport, :count).by(-1)
    end
  end
end
