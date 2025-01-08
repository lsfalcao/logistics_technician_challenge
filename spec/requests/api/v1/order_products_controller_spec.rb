require "rails_helper"

RSpec.describe "Api::V1::OrderProductProductsControllers", type: :request do
  let!(:user) { create(:user) }
  let!(:order) { create(:order, user: user) }
  let!(:order_product) { create(:order_product, order: order) }
  let(:valid_attributes) {
    {
      value: Faker::Number.decimal(l_digits: 4, r_digits: 2),
      product_id: Faker::Number.number(digits: 4),
      order_id: order.id
    }
  }
  let(:invalid_attributes) { {product_id: ""} }

  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_order_products_url

      expect(response).to be_successful
      expect(response.body).to include(order_product.product_id.to_s)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get api_v1_order_product_url(order_product)

      expect(response).to be_successful
      expect(response.body).to include(order_product.product_id.to_s)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new OrderProduct" do
        expect {
          post api_v1_order_products_url, params: {order_product: valid_attributes}
        }.to change(OrderProduct, :count).by(1)
        order_product = OrderProduct.last
        expect(order_product.product_id.to_s).to eq(valid_attributes[:product_id].to_s)
      end
    end

    context "with invalid parameters" do
      it "does not create a new OrderProduct" do
        expect {
          post api_v1_order_products_url, params: {order_product: invalid_attributes}
        }.to change(OrderProduct, :count).by(0)
      end

      it "renders a unprocessable_entity response" do
        post api_v1_order_products_url, params: {order_product: invalid_attributes}
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { {product_id: Faker::Number.number(digits: 4)} }

      it "updates the requested order_product" do
        order_product = OrderProduct.create! valid_attributes
        patch api_v1_order_product_url(order_product), params: {order_product: new_attributes}
        order_product.reload
        expect(order_product.product_id.to_s).to eq(new_attributes[:product_id].to_s)
      end
    end

    context "with invalid parameters" do
      it "renders a unprocessable_entity response" do
        order_product = OrderProduct.create! valid_attributes
        patch api_v1_order_product_url(order_product), params: {order_product: invalid_attributes}
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested order_product" do
      order_product = OrderProduct.create! valid_attributes
      expect {
        delete api_v1_order_product_url(order_product)
      }.to change(OrderProduct, :count).by(-1)
    end
  end
end
