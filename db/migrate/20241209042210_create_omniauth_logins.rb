class CreateOmniauthLogins < ActiveRecord::Migration[8.0]
  def change
    create_table :omniauth_logins do |t|
      t.string :provider, null: false, index: true
      t.string :uid, null: false, index: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps

      t.index [ :uid, :provider ], name: "index_uid_provider_uniqueness", unique: true
      t.index [ :user_id, :provider ], name: "index_user_id_provider_uniqueness", unique: true
    end
  end
end
