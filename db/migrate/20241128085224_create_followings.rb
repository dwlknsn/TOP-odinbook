class CreateFollowings < ActiveRecord::Migration[8.0]
  def change
    create_table :followings do |t|
      t.belongs_to :followee, null: false, foreign_key: { to_table: :users }
      t.belongs_to :follower, null: false, foreign_key: { to_table: :users }
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :followings, [ :followee_id, :follower_id ], unique: true
  end
end
