class Event < ActiveRecord::Base
  validates_presence_of :name, :location, :description, :image_url, :event_date
  validates_length_of :description, :image_url, maximum: 1000
  validates_length_of :name, maximum: 300
  validates_length_of :location, maximum: 200

end
