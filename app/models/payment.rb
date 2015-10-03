class Payment < ActiveRecord::Base
  validates :token, presence: true
  validates :schedule, presence: true
  validates :donation_id, presence: true
  validates :customer_id, presence: true
end
