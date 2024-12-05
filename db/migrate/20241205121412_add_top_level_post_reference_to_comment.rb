class AddTopLevelPostReferenceToComment < ActiveRecord::Migration[8.0]
  def change
    add_reference :comments, :top_level_post, null: false, foreign_key: { to_table: :posts }
  end
end
