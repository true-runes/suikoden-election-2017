class IndexController < ApplicationController
  include TweetsJoinUsers
  include SelectTweetsByHashtag

  def index
    source_tweets = without_retweets
    @vote_amount = select_tweets_by_hashtag(source_tweets, "幻水総選挙2017投票").length
  end
end
