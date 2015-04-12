class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.string :photo
      t.string :user_id

      t.timestamps null: false
    end
  end
end