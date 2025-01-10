FactoryBot.define do
  factory :legacy_order_import do
    client
    file { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, "/spec/fixtures/files/data_1.txt"))) }
  end
end
