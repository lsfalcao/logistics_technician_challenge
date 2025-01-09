class Api::V1::Clients::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix

  respond_to :json

  private

  def respond_with(current_client, _opts = {})
    if resource.persisted?
      render json: {
        status: {code: 200, message: "Signed up successfully."},
        data: ClientSerializer.new(current_client).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: {message: "Client couldn't be created successfully. #{current_client.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end
end
