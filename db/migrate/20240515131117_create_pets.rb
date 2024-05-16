class CreatePets < ActiveRecord::Migration[7.1]
  def change
    create_table :pets do |t|
      t.references :shelter, null: false, foreign_key: true
      t.string :name
      t.string :species
      t.string :breed
      t.integer :age
      t.string :size
      t.string :gender
      t.string :temperament
      t.text :description
      t.string :photo_url
      t.integer :adoption_status, default: 0
      t.string :location

      t.timestamps
    end
  end
end
