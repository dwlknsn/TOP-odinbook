class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.belongs_to :author, null: false, foreign_key: { to_table: :users }
      t.integer :commentable_id, null: false
      t.string :commentable_type, null: false
      t.text :body, null: false

      t.timestamps
    end

    add_index :comments, [ :commentable_id, :commentable_type ]
  end
end
