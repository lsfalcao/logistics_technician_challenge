class Api::AppController < ApplicationController
  respond_to :json
  before_action :authenticate_client!
end
