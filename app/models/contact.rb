class Contact < ActiveRecord::Base

    has_many :memberships
    has_many :interests
    has_many :donations
    has_many :correspondences

    validates_length_of :first_name, :last_name, :address, maximum: 200
    validates_length_of :zip, :phone, maximum: 16
    validates_length_of :city, :email, maximum: 100
    validates_length_of :state, is: 2
    validates_presence_of :first_name, :address
    validates_uniqueness_of :address
end
