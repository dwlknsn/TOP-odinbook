class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :username, null: false, index: { unique: true, name: "unique_usernames" }
      t.string :display_name, null: false

      t.timestamps
    end
  end
end
