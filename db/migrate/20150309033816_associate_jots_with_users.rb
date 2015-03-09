class AssociateJotsWithUsers < ActiveRecord::Migration
  def change
    Jot.delete_all
    add_column :jots, :user_id, :integer, null: false
    add_index :jots, :user_id
  end
end
