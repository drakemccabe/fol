class DonationSerializer < ActiveModel::Serializer
  attributes :id, :amount, :contact_id
  has_one :contact
end
