class AddAirtable < ActiveRecord::Migration
  def change
    add_column :contacts, :airtable_id, :string
  end
end
