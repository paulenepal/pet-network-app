class CreateShelters < ActiveRecord::Migration[7.1]
  def change
    create_table :shelters do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :website
      t.text :description

      t.timestamps
    end
  end
end
