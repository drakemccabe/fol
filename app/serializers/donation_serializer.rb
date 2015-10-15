class DonationSerializer < ActiveModel::Serializer
  attributes :id, :amount, :contact_id, :created_at
  has_one :contact

  def created_at
    object.created_at.strftime('%m/%d/%Y')
  end
end
