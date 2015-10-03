class AddPaymentsTable < ActiveRecord::Migration
  def change
    create_table(:payments) do |t|
      t.string :token, null: false
      t.boolean :schedule, null: false
      t.integer :donation_id, null: false
      t.string :customer_id, null: false
    end
  end
end
