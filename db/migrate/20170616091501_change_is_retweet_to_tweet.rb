class ChangeIsRetweetToTweet < ActiveRecord::Migration[5.1]
  def change
    rename_column :tweets, :is_retweeted, :is_retweet
  end
end
