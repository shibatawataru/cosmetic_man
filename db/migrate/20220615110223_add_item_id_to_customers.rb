class AddItemIdToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :item_id, :integer
  end
end
