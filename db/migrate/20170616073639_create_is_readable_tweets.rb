class CreateIsReadableTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :is_readable_tweets do |t|
      t.string :tweet_id
      t.boolean :is_readable

      t.timestamps
    end
  end
end
