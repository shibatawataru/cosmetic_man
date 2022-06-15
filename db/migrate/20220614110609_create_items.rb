class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :customer_id, null: false
      t.string :itemname, null: false
      t.text :body, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
