class Correspondence < ActiveRecord::Base
  belongs_to :contact

  validates :note, length: { maximum: 1000 }, presence: true
end
