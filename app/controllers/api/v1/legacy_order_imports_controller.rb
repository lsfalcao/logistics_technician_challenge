class Api::V1::LegacyOrderImportsController < Api::AppController
  before_action :set_legacy_order_import, only: %i[show destroy]

  # GET /legacy_order_imports
  def index
    @legacy_order_imports = LegacyOrderImport.all

    render json: @legacy_order_imports
  end

  # GET /legacy_order_imports/1
  def show
    if stale?(last_modified: @legacy_order_import.updated_at)
      render json: @legacy_order_import
    end
  end

  # POST /legacy_order_imports
  def create
    if params[:file].blank?
      return render json: {
        status: {message: "LegacyOrderImport couldn't be created without file."}
      }, status: :unprocessable_entity
    end

    @legacy_order_import = LegacyOrderImport.new(file: params[:file])
    @legacy_order_import.client = current_client

    if @legacy_order_import.save
      render json: @legacy_order_import, status: :created
    else
      render json: @legacy_order_import.errors, status: :unprocessable_entity
    end
  end

  # DELETE /legacy_order_imports/1
  def destroy
    @legacy_order_import.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_legacy_order_import
    @legacy_order_import = LegacyOrderImport.find(params[:id])
  end
end
