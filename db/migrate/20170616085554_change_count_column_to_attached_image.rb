class ChangeCountColumnToAttachedImage < ActiveRecord::Migration[5.1]
  def change
    rename_column :attached_images, :count, :media_id
    add_index :attached_images, :media_id, unique: true
    remove_column :hashtags, :count
  end
end
