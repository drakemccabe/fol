class AddNullConstraintToDonation < ActiveRecord::Migration
  def change
    change_column :donations, :contact_id, :integer, null: false
  end
end
