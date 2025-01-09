class LegacyOrderImport < ApplicationRecord
  belongs_to :client

  has_one_attached :file
end
