class AddFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :subscriber_id, null: false
      t.integer :user_id, null: false

      t.timestamp :created_at, null:false
    end

    add_index :followers, [:subscriber_id, :user_id], unique: true
  end
end
