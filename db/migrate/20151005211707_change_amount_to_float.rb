class ChangeAmountToFloat < ActiveRecord::Migration
  def change
    change_column :donations, :amount, :float, null: false
  end
end
