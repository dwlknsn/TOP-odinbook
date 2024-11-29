class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :likeable_id, null: false
      t.string :likeable_type, null: false

      t.timestamps
    end

    add_index :likes, [ :user_id, :likeable_id, :likeable_type ], unique: true
    add_index :likes, [ :likeable_id, :likeable_type ]
  end
end
