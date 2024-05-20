class AddDeviseInvitableToUsers < ActiveRecord::Migration[7.1]
  def up
    change_table :users do |t|
      t.string :invitation_token
      t.datetime :invitation_created_at
      t.datetime :invitation_sent_at
      t.datetime :invitation_accepted_at
      t.integer :invitation_limit
      t.references :invited_by, polymorphic: true
      t.integer :invitations_count, default: 0
    end
    add_index :users, :invitation_token, unique: true
    add_index :users, :invited_by_id
  end

  def down
    change_table :users do |t|
      t.remove :invitation_token, :invitation_created_at, :invitation_sent_at, :invitation_accepted_at, :invitation_limit, :invited_by_id, :invited_by_type, :invitations_count
    end
  end
end
