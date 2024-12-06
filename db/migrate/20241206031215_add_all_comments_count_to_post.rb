class AddAllCommentsCountToPost < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :all_comments_count, :integer, default: 0, null: false
  end
end
