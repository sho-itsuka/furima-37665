class CreateDelivaries < ActiveRecord::Migration[6.0]
  def change
    create_table :delivaries do |t|
      t.string :postcode,          null: false
      t.integer :ship_area_id,     null: false
      t.string :city,              null: false
      t.string :block,             null: false
      t.string :building
      t.string :phonenumber,       null: false
      t.references :order,         null: false, foreign_key: true
      t.timestamps
    end
  end
end
