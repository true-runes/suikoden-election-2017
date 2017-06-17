class CreateHashtags < ActiveRecord::Migration[5.1]
  def change
    create_table :hashtags do |t|
      t.string :tweet_id
      t.integer :count
      t.string :tagname

      t.timestamps
    end
    add_index :hashtags, :tweet_id, unique: true
  end
end
