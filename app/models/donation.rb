class Donation < ActiveRecord::Base
  belongs_to :contact

  validates_presence_of :amount, :created_at, :contact_id
  validates_numericality_of :amount, greater_than: 0.0

  after_create :add_member

  private

  def add_member
    membership = Membership.find_or_initialize_by(contact_id: self.contact_id)
    membership.update(status: true)

    if self.amount >= 100.0
      lifetime = true
      exp_date = self.created_at + 100.year
      membership.update(lifetime: lifetime,
                        expiration_date: exp_date)
    else
      exp_date = self.created_at + 1.year
    end
  end
end
