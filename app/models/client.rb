class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :validatable
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :trackable,
    :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :legacy_order_imports, dependent: :destroy

  validates :name, presence: true
end
