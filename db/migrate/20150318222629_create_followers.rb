class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :user_id, index: true
      t.integer :subscriber_id, index: true

      t.timestamps null: false
    end
    add_foreign_key :followers, :users
  end
end
