class DonationSerializer < ActiveModel::Serializer
  attributes :id, :amount, :contact_id, :created_at
  has_one :contact
end
