class LegacyOrderImport < ApplicationRecord
  belongs_to :client

  has_one_attached :file

  after_create :call_legacy_order_process_job

  private

  def call_legacy_order_process_job
    LegacyOrderProcessJob.perform_async(id)
  end
end
