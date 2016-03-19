class CreateVisibilityAccesses < ActiveRecord::Migration
  def change
    create_table :visibility_accesses do |t|
      t.integer :visibility_id
      t.integer :user_id
      t.string :access

      t.timestamps null: false
    end
    add_index :visibility_accesses, :visibility_id
    add_index :visibility_accesses, [:visibility_id, :user_id]
  end
end
