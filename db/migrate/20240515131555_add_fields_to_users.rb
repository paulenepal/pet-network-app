class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :integer, default: 0
    add_column :users, :approved, :boolean, default: false
    add_column :users, :username, :string
    add_column :users, :location, :string
  end
end
