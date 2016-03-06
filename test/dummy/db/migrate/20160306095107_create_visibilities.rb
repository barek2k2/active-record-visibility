class CreateVisibilities < ActiveRecord::Migration
  def change
    create_table :visibilities do |t|
      t.integer :visible_id
      t.string :visible_type
      t.string :visible_attribute
      t.boolean :is_visible, default: true

      t.timestamps null: false
    end
  end
end
