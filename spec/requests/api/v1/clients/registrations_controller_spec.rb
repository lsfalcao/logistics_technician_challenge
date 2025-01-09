require "rails_helper"

RSpec.describe "Api::V1::Clients::RegistrationsController", type: :request do
  let(:valid_attributes) {
    {
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      password: Faker::Internet.password
    }
  }
  let(:invalid_attributes) { {name: ""} }

  describe "POST /signup" do
    context "with valid parameters" do
      it "creates a new Client" do
        expect {
          post client_registration_url, params: {client: valid_attributes}
        }.to change(Client, :count).by(1)
        client = Client.last
        expect(client.name).to eq(valid_attributes[:name])
      end
    end

    context "with invalid parameters" do
      it "does not create a new Client" do
        expect {
          post client_registration_url, params: {client: invalid_attributes}
        }.to change(Client, :count).by(0)
      end

      it "renders a unprocessable_entity response" do
        post client_registration_url, params: {client: invalid_attributes}
        expect(response.status).to eq(422)
      end
    end
  end
end
