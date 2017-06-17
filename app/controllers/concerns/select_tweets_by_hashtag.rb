module SelectTweetsByHashtag
  # HACK: 引数 hashtag は、複数の値を取れるようにする
  def select_tweets_by_hashtag(tweets, hashtag)
    @selected_tweets = []
    tweets.each do |tweet|
      target_tweets = Hashtag.where(tweet_id: tweet.tweet_id)
      target_tweets.each do |target_tweet|
        @selected_tweets << tweet if target_tweet.tagname == hashtag
      end
    end
    @selected_tweets
  end
end
