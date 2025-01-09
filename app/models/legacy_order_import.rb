class LegacyOrderImport < ApplicationRecord
  belongs_to :client

  has_one_attached :file

  after_create :call_legacy_order_process_job

  def file_current_path
    ActiveStorage::Blob.service.path_for(file.key)
  end

  private

  def call_legacy_order_process_job
    LegacyOrderProcessJob.perform_async(id)
  end
end
