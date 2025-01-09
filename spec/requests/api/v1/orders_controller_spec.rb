require "rails_helper"

RSpec.describe "Api::V1::OrdersControllers", type: :request do
  let!(:client) { create(:client) }
  let!(:user) { create(:user) }
  let!(:order) { create(:order, user: user) }
  let(:valid_attributes) { {date: Faker::Date.between(from: 6.months.ago, to: Date.current), user_id: user.id} }
  let(:invalid_attributes) { {date: ""} }

  before do
    sign_in client
  end

  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_orders_url

      expect(response).to be_successful
      expect(response.body).to include(order.date.to_s)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get api_v1_order_url(order)

      expect(response).to be_successful
      expect(response.body).to include(order.date.to_s)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Order" do
        expect {
          post api_v1_orders_url, params: {order: valid_attributes}
        }.to change(Order, :count).by(1)
        order = Order.last
        expect(order.date.to_s).to eq(valid_attributes[:date].to_s)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Order" do
        expect {
          post api_v1_orders_url, params: {order: invalid_attributes}
        }.to change(Order, :count).by(0)
      end

      it "renders a unprocessable_entity response" do
        post api_v1_orders_url, params: {order: invalid_attributes}
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { {date: Faker::Date.between(from: 6.months.ago, to: Date.current)} }

      it "updates the requested order" do
        order = Order.create! valid_attributes
        patch api_v1_order_url(order), params: {order: new_attributes}
        order.reload
        expect(order.date.to_s).to eq(new_attributes[:date].to_s)
      end
    end

    context "with invalid parameters" do
      it "renders a unprocessable_entity response" do
        order = Order.create! valid_attributes
        patch api_v1_order_url(order), params: {order: invalid_attributes}
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested order" do
      order = Order.create! valid_attributes
      expect {
        delete api_v1_order_url(order)
      }.to change(Order, :count).by(-1)
    end
  end
end
