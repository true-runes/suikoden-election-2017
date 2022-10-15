class TweetAsVoteController < ApplicationController
  include TweetsJoinUsers
  include SelectTweetsByHashtag

  def index
    # source_tweets = without_retweets
    source_tweets = without_retweets_and_limited_period
    selected_tweets = select_tweets_by_hashtag(source_tweets, '幻水総選挙2017投票')

    # TODO: コントローラに詰め込みすぎだし NOT DRY
    unreadable_tweet_ids = IsReadableTweet.where(is_readable: false)
    @removed_tweet_ids = []
    unreadable_tweet_ids.each do |tweet|
      @removed_tweet_ids << tweet.tweet_id
    end

    result_tweets = selected_tweets.reject do |element|
      @removed_tweet_ids.include?(element.tweet_id)
    end

    @kaminaried_tweets = Kaminari.paginate_array(result_tweets).page(params[:page]).per(15) # HACK: 個別に設定を決めないようにする
  end
end
