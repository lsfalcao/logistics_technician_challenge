class ClientSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name
end
