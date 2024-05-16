class AddPetToFavorites < ActiveRecord::Migration[7.1]
  def change
    add_reference :favorites, :pet, null: false, foreign_key: true
  end
end