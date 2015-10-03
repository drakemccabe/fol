class NewDonation
  def initialize(customer, amount, charge)
    @address = customer.sources.data.first.address_line1
    @city = customer.sources.data.first.address_city
    @state = customer.sources.data.first.address_state
    @zip = customer.sources.data.first.address_zip
    @customer = customer
    @charge = charge
    @amount = amount
  end

  def add_donation!
    address = normalize_address
    contact = associate(address)
    new_with_user_address(contact, address)
    new_with_standardized_address(contact, address)
    if contact.exists?
      binding.pry
      Donation.create(amount: @amount,
                      contact_id: contact.first.id,
                      stripe_token: @charge.id,
                      created_at: Date.today)
    end
  end

  private

    def associate(address)
      if address.nil?
        association = Contact.where(address: @street)
      else
        association = Contact.where(address:
                                    address.
                                    first.delivery_line_1)
      end
      association
    end

    def normalize_address
      SmartyStreets::StreetAddressApi.call(
        SmartyStreets::StreetAddressRequest.new(
          input_id: "1",
          street: @address,
          city: @city,
          state: @state,
          zipcode: @zip))
    end

    def new_with_user_address(contact, address)
      if contact.empty? && address.nil?
        new_contact = Contact.new(address: @address,
                                  city: @city,
                                  state: @state,
                                  zip: @zip,
                                  first_name: @customer.sources.data.first.name,
                                  email: @customer.email)
        if new_contact.save
          Donation.create(amount: @amount,
                          contact_id: new_contact.id,
                          stripe_token: @charge.id,
                          created_at: Date.today)
        end
      end
    end

    def new_with_standardized_address(contact, address)
      if contact.empty? && address != nil
        new_contact = Contact.new(address: address.first.delivery_line_1,
                                  city: address.first.components.city_name,
                                  state: address.first.components.state_abbreviation,
                                  zip: address.first.components.to_hash[:zipcode],
                                  first_name: @customer.sources.data.first.name,
                                  email: @customer.email)
        if new_contact.save
          Donation.create(amount: @amount,
                          contact_id: new_contact.id,
                          stripe_token: @charge.id,
                          created_at: Date.today)
        end
      end
    end
end
