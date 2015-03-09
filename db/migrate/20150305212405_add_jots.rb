class AddJots < ActiveRecord::Migration
  def change
    create_table :jots do |t|
      t.string :content

      t.timestamps
    end
  end
end
