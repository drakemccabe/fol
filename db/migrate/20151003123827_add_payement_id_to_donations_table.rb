class AddPayementIdToDonationsTable < ActiveRecord::Migration
  def change
    add_column :donations, :stripe_token, :string
  end
end
