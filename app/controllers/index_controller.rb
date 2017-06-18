class IndexController < ApplicationController
  include TweetsJoinUsers
  include SelectTweetsByHashtag

  def index
    source_tweets = without_retweets_and_gensosenkyo_loose_limited_period

    # TODO: コントローラに詰め込みすぎ
    unreadable_tweet_ids = IsReadableTweet.where(is_readable: false)
    @removed_tweet_ids = []
    unreadable_tweet_ids.each do |tweet|
      @removed_tweet_ids << tweet.tweet_id
    end

    amount_tweets = source_tweets.reject do |element|
      @removed_tweet_ids.include?(element.tweet_id)
    end

    @vote_amount = select_tweets_by_hashtag(amount_tweets, "幻水総選挙2017投票").length
  end
end
