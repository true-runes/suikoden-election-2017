module TweetsJoinUsers
  # TODO: find_by_sql は良くない
  def without_retweets
    Tweet.find_by_sql([%Q{SELECT * FROM tweets INNER JOIN users ON tweets.user_id = users.user_id WHERE is_retweet = false ORDER BY tweets.tweeted_at DESC}])
  end

  # TODO: find_by_sql は良くない
  def tweets_by_specific_user(screen_name)
    Tweet.find_by_sql([%Q{SELECT * FROM tweets INNER JOIN users ON tweets.user_id = users.user_id WHERE screen_name = ? AND is_retweet = false ORDER BY tweets.tweeted_at DESC}, screen_name])
  end
end
