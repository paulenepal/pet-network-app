class CreateAdoptionApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :adoption_applications do |t|
      t.references :adopter, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true
      t.integer :status, default: 0
      t.date :application_date

      t.timestamps
    end
  end
end
