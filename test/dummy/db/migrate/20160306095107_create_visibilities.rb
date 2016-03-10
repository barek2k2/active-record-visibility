class CreateVisibilities < ActiveRecord::Migration
  def change
    create_table :visibilities do |t|
      t.integer :visible_id
      t.string :visible_type
      t.string :visible_attribute
      t.boolean :is_visible, default: true

      t.timestamps null: false
    end

    add_index :visibilities, [:visible_id, :visible_type], :name => "index_visible"
    add_index :visibilities, [:visible_id, :visible_type, :visible_attribute], :name => "index_visible_attr"

  end
end
