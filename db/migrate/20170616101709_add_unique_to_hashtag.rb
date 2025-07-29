class AddUniqueToHashtag < ActiveRecord::Migration[5.1]
  def change
    add_index :hashtags, %i[tweet_id tagname], unique: true
  end
end
