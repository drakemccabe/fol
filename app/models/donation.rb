class Donation < ActiveRecord::Base
  belongs_to :contact

  validates_presence_of :amount, :created_at, :contact_id
  validates_numericality_of :amount, greater_than: 0.0

  after_create :send_to_airtable, :add_member

  private

  def add_member
    membership = Membership.find_or_initialize_by(contact_id: self.contact_id)
    membership.update(status: true)

    if self.amount >= 100.0
      lifetime = true
      exp_date = self.created_at + 100.year
      membership.update(lifetime: lifetime,
                        expiration_date: exp_date)
      lifetime_membership
    else
      exp_date = self.created_at + 1.year
      one_year_membership
    end
  end

  def send_to_airtable
    amount = self.amount
    date = self.created_at
    id = self.contact.airtable_id
    client = Airtable::Client.new(ENV['AIRTABLE'])
    table = client.table("appxOPxNHD50YNXD5", "Donations")
    record = Airtable::Record.new("Amount" => amount,
                                  "From Contact" => [id],
                                   " Date of Donation" => date,
                                   "Thank You Sent?" => true)
    table.create(record)
  end

  def one_year_membership
    exp_date = self.created_at + 365
    id = self.contact.airtable_id
    client = Airtable::Client.new(ENV['AIRTABLE'])
    table = client.table("appxOPxNHD50YNXD5", "Contacts")
    record = table.find(id)
    record[:until] = "2015-11-10"
    table.update(record)
  end

  def lifetime_membership
    id = self.contact.airtable_id
    client = Airtable::Client.new(ENV['AIRTABLE'])
    table = client.table("appxOPxNHD50YNXD5", "Contacts")
    record = table.find(id)
    record[:lifetime] = true
    table.update(record)
  end
end
