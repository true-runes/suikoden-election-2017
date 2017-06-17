class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string :tweet_id
      t.string :user_id
      t.string :text
      t.string :full_text
      t.string :uri
      t.datetime :tweeted_at
      t.boolean :is_retweeted
      t.boolean :is_attached_image
      t.boolean :has_hashtag

      t.timestamps
    end
    add_index :tweets, :tweet_id, unique: true
  end
end
