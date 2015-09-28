class Donation < ActiveRecord::Base
  belongs_to :contact

  validates_presence_of :amount, :created_at
end
