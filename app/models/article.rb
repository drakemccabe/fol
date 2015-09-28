class Article < ActiveRecord::Base
  validates_presence_of :title, :category, :author, :body, :image_url
  validates_length_of :category, :author, maximum: 300
  validates_length_of :title, in: 4..500
  validates_length_of :image_url, maximum: 1000
end
