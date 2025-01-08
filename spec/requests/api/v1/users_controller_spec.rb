require "rails_helper"

RSpec.describe "Api::V1::UsersControllers", type: :request do
  let!(:user) { create(:user) }
  let(:valid_attributes) { {name: Faker::Name.name} }
  let(:invalid_attributes) { {name: ""} }

  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_users_url

      expect(response).to be_successful
      expect(response.body).to include(user.name)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get api_v1_user_url(user)

      expect(response).to be_successful
      expect(response.body).to include(user.name)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post api_v1_users_url, params: {user: valid_attributes}
        }.to change(User, :count).by(1)
        user = User.last
        expect(user.name).to eq(valid_attributes[:name])
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post api_v1_users_url, params: {user: invalid_attributes}
        }.to change(User, :count).by(0)
      end

      it "renders a unprocessable_entity response" do
        post api_v1_users_url, params: {user: invalid_attributes}
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { {name: Faker::Name.name} }

      it "updates the requested user" do
        user = User.create! valid_attributes
        patch api_v1_user_url(user), params: {user: new_attributes}
        user.reload
        expect(user.name).to eq(new_attributes[:name])
      end
    end

    context "with invalid parameters" do
      it "renders a unprocessable_entity response" do
        user = User.create! valid_attributes
        patch api_v1_user_url(user), params: {user: invalid_attributes}
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete api_v1_user_url(user)
      }.to change(User, :count).by(-1)
    end
  end
end
