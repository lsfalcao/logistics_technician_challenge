class Api::V1::Clients::SessionsController < Devise::SessionsController
  include RackSessionsFix

  respond_to :json

  private

  def respond_with(current_client, _opts = {})
    render json: {
      status: {
        code: 200,
        message: "Logged in successfully.",
        token: current_token,
        data: {client: ClientSerializer.new(current_client).serializable_hash[:data][:attributes]}
      }
    }, status: :ok
  end

  def respond_to_on_destroy
    if request.headers["Authorization"].present?
      jwt_payload = JWT.decode(request.headers["Authorization"].split(" ").last, Rails.application.credentials.devise_jwt_secret_key!).first
      current_client = Client.find_by(id: jwt_payload['sub'], jti: jwt_payload['jti'])
    end

    if current_client
      render json: {
        status: 200,
        message: "Logged out successfully."
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

  private

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
