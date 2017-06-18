class CheckVoteController < ApplicationController
  protect_from_forgery with: :null_session # HACK: スマートフォン版 Chrome 対策
  include TweetsJoinUsers
  include SelectTweetsByHashtag

  def index
  end

  def result
    @screen_name = params[:screen_name].nil? ? "" : params[:screen_name].gsub(/@/, "")
    tweets_by_specific_user = tweets_by_specific_user(@screen_name)
    @result_tweets = select_tweets_by_hashtag(tweets_by_specific_user, "幻水総選挙2017投票", "幻水総選挙2017")
  end
end
