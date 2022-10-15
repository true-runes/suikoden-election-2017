# rubocop:disable Layout/LineLength
module TweetsJoinUsers
  # TODO: find_by_sql は良くない
  def without_retweets
    Tweet.find_by_sql([%(SELECT * FROM tweets INNER JOIN users ON tweets.user_id = users.user_id WHERE is_retweet = false ORDER BY tweets.tweeted_at DESC)])
  end

  # TODO: find_by_sql は良くない
  # TODO: NOT DRY
  def without_retweets_and_limited_period
    Tweet.find_by_sql([%{SELECT * FROM tweets INNER JOIN users ON tweets.user_id = users.user_id WHERE (is_retweet = false) AND (tweeted_at BETWEEN '2017/06/16 12:00:00' AND '2017/06/18 00:00:00') ORDER BY tweets.tweeted_at DESC}])
  end

  def without_retweets_and_loose_limited_period
    Tweet.find_by_sql([%{SELECT * FROM tweets INNER JOIN users ON tweets.user_id = users.user_id WHERE (is_retweet = false) AND (tweeted_at BETWEEN '2017/06/16 11:45:00' AND '2017/06/18 03:00:00') ORDER BY tweets.tweeted_at DESC}])
  end

  def without_retweets_and_gensosenkyo_loose_limited_period
    Tweet.find_by_sql([%{SELECT * FROM tweets INNER JOIN users ON tweets.user_id = users.user_id WHERE (is_retweet = false) AND (users.screen_name != 'gensosenkyo') AND (tweeted_at BETWEEN '2017/06/16 11:45:00' AND '2017/06/18 03:00:00') ORDER BY tweets.tweeted_at DESC}])
  end

  def without_retweets_and_gensosenkyo_loose_limited_period_name_sort
    Tweet.find_by_sql([%{SELECT * FROM tweets INNER JOIN users ON tweets.user_id = users.user_id WHERE (is_retweet = false) AND (users.screen_name != 'gensosenkyo') AND (tweeted_at BETWEEN '2017/06/16 11:45:00' AND '2017/06/18 03:00:00') ORDER BY users.screen_name ASC}])
  end

  def for_after_party
    Tweet.find_by_sql([%{SELECT * FROM tweets INNER JOIN users ON tweets.user_id = users.user_id WHERE (is_retweet = false) AND (tweeted_at > '2017/06/24 11:45:00') ORDER BY tweets.tweeted_at DESC}])
  end

  # TODO: find_by_sql は良くない
  def tweets_by_specific_user(screen_name)
    Tweet.find_by_sql([
                        %(SELECT * FROM tweets INNER JOIN users ON tweets.user_id = users.user_id WHERE screen_name = ? AND is_retweet = false ORDER BY tweets.tweeted_at DESC), screen_name
                      ])
  end

  # TODO: find_by_sql は良くない
  # TODO: NOT DRY
  def tweets_by_specific_user_limited_period(screen_name)
    Tweet.find_by_sql([
                        %{SELECT * FROM tweets INNER JOIN users ON tweets.user_id = users.user_id WHERE (screen_name = ?) AND (is_retweet = false) AND (tweeted_at BETWEEN '2017/06/16 12:00:00' AND '2017/06/18 00:00:00') ORDER BY tweets.tweeted_at DESC}, screen_name
                      ])
  end

  def tweets_by_specific_user_limited_loose_period(screen_name)
    Tweet.find_by_sql([
                        %{SELECT * FROM tweets INNER JOIN users ON tweets.user_id = users.user_id WHERE (screen_name = ?) AND (is_retweet = false) AND (tweeted_at BETWEEN '2017/06/16 11:45:00' AND '2017/06/18 03:00:00') ORDER BY tweets.tweeted_at DESC}, screen_name
                      ])
  end

  def tweets_by_specific_user_limited_count_vote_period(screen_name)
    Tweet.find_by_sql([
                        %{SELECT * FROM tweets INNER JOIN users ON tweets.user_id = users.user_id WHERE (screen_name = ?) AND (is_retweet = false) AND (tweeted_at BETWEEN '2017/06/25 02:45:00' AND '2017/06/25 10:00:00') ORDER BY tweets.tweeted_at ASC}, screen_name
                      ])
  end

  def attached_image_uri(target_tweet_id)
    Tweet.find_by_sql([%(SELECT * FROM attached_images WHERE tweet_id = ? ORDER BY media_id ASC), target_tweet_id])
  end
end
# rubocop:enable Layout/LineLength
