class AddGpsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :longitude, :decimal, { precision: 10, scale: 6 }
    add_column :contacts, :latitude, :decimal, { precision: 10, scale: 6 }
  end
end
