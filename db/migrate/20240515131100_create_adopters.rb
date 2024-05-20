class CreateAdopters < ActiveRecord::Migration[7.1]
  def change
    create_table :adopters do |t|
      t.references :user, null: false, foreign_key: true
      t.string :preference
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
