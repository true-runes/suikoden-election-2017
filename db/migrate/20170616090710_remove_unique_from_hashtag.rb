class RemoveUniqueFromHashtag < ActiveRecord::Migration[5.1]
  def change
    remove_index :hashtags, :tweet_id
  end
end
