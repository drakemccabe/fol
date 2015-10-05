class Donation < ActiveRecord::Base
  belongs_to :contact

  validates_presence_of :amount, :created_at, :contact_id
  validates_numericality_of :amount, greater_than: 0.0
end
