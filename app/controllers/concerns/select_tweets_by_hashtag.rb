module SelectTweetsByHashtag
  # HACK: 引数 hashtag は、複数の値を取れるようにする（現状は場当たり的にも程がある）
  def select_tweets_by_hashtag(tweets, hashtag_a, hashtag_b = '')
    @selected_tweets = []

    tweets.each do |tweet|
      target_tweets = Hashtag.where(tweet_id: tweet.tweet_id)

      target_tweets.each do |target_tweet| # rubocop:disable Lint/UnreachableLoop (FIXME:)
        @selected_tweets << tweet if [hashtag_a, hashtag_b].include?(target_tweet.tagname)

        break # TODO: 「どちらかが含まれていた時点で終了」ということであるが、論理的に複雑である
      end
    end
    @selected_tweets
  end
end
