class CreatePetComments < ActiveRecord::Migration[7.1]
  def change
    create_table :pet_comments do |t|
      t.references :pet, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :comment_text

      t.timestamps
    end
  end
end
