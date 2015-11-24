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

    after_create :add_airtable

    private

    def add_airtable
      name = self.first_name
      telephone = self.phone
      email = self.email
      address = self.address
      city = self.city
      state = self.state
      zipcode = self.zip
      client = Airtable::Client.new(ENV['AIRTABLE'])
      table = client.table("appxOPxNHD50YNXD5", "Contacts")
      record = Airtable::Record.new("Name" => name,
                                    "Telephone #" => telephone,
                                    "Email" => email,
                                    "Address" => address,
                                    "City" => city,
                                    "State" => state,
                                    "Zipcode" => zipcode)

      send = table.create(record)
      self.airtable_id = send.id
      self.save
    end
end
