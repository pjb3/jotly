class AddLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :jot_id, null: false
      t.integer :user_id, null: false

      t.timestamp :created_at, null: false
    end

    add_index :likes, [:jot_id, :user_id], unique: false
  end
end
