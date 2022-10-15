class CheckVoteController < ApplicationController
  protect_from_forgery with: :null_session # HACK: スマートフォン版 Chrome 対策
  include TweetsJoinUsers
  include SelectTweetsByHashtag

  def index; end

  def result # rubocop:disable Metrics/AbcSize
    @screen_name = params[:screen_name].nil? ? '' : params[:screen_name].gsub(/@/, '')

    # tweets_by_specific_user = tweets_by_specific_user(@screen_name)
    # tweets_by_specific_user = tweets_by_specific_user_limited_period(@screen_name)
    tweets_by_specific_user = tweets_by_specific_user_limited_loose_period(@screen_name)
    select_tweets_by_hashtag = select_tweets_by_hashtag(tweets_by_specific_user, '幻水総選挙2017投票', '幻水総選挙2017')

    # TODO: コントローラに詰め込みすぎ
    unreadable_tweet_ids = IsReadableTweet.where(is_readable: false)
    @removed_tweet_ids = []
    unreadable_tweet_ids.each do |tweet|
      @removed_tweet_ids << tweet.tweet_id
    end

    @result_tweets = select_tweets_by_hashtag.reject do |element|
      @removed_tweet_ids.include?(element.tweet_id)
    end
  end
end
# @msmrabbit: deleted tweet disappointed #=> OK!
# I am Blocked: 875719656111095813
