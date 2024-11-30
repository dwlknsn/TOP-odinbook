class RemoveBodyFromPosts < ActiveRecord::Migration[8.0]
  def change
    remove_column :posts, :body
  end
end
