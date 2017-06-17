class ChangeMediaIdStrToAttachedImage < ActiveRecord::Migration[5.1]
  def change
    change_column :attached_images, :media_id, :string # from :id to :string
  end
end
