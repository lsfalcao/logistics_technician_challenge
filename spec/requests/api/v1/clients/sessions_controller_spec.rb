require "rails_helper"

RSpec.describe "Api::V1::Clients::SessionsController", type: :request do
  let!(:client) { create(:client) }
  let(:valid_attributes) {
    {
      email: client.email,
      password: client.password
    }
  }
  let(:invalid_attributes) { {email: "", password: ""} }

  describe "POST /login" do
    context "with valid parameters" do
      before do
        post client_session_url, params: {client: valid_attributes}
      end

      it 'returns 200' do
        expect(response).to be_successful
      end

      it 'returns client client name' do
        expect(response.body).to include(client.name)
      end

      it 'returns JTW token in authorization header' do
        expect(response.headers['Authorization']).to be_present
      end

      it 'returns valid JWT token' do
        decoded_token = JWT.decode(response.headers["Authorization"].split(" ").last, Rails.application.credentials.devise_jwt_secret_key!).first
        expect(decoded_token["sub"].to_i).to be(client.id)
      end
    end

    context "with invalid parameters" do
      it "renders a unauthorized response" do
        post client_session_url, params: {client: invalid_attributes}
        expect(response.status).to eq(401)
      end
    end
  end

  describe "POST /logout" do
    context "with valid parameters" do
      before do
        post client_session_url, params: {client: valid_attributes}
        @jwt = response.headers['Authorization']
      end

      it "logout client" do
        delete destroy_client_session_url, headers: {"Authorization" => @jwt}
        expect(response).to be_successful
        expect(response.body).to include("Logged out successfully.")
        expect(
          get root_url, headers: {"Authorization" => @jwt}
        ).to eq(401)
      end
    end

    context "with invalid parameters" do
      it "renders a unauthorized response" do
        delete destroy_client_session_url, params: {client: invalid_attributes}
        expect(response.status).to eq(401)
      end
    end
  end
end
