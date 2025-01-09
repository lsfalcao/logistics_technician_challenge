class LegacyOrderProcessJob
  include Sidekiq::Job

  def perform(legacy_order_import_id)
    legacy_order_import = LegacyOrderImport.find_by(id: legacy_order_import_id)
    LegacyOrderImports::Process.call(legacy_order_import) if legacy_order_import
  end
end
