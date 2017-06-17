class TweetAsPrController < ApplicationController
  include TweetsJoinUsers
  include SelectTweetsByHashtag

  def index
    source_tweets = without_retweets
    selected_tweets = select_tweets_by_hashtag(source_tweets, "幻水総選挙運動")
    @kaminaried_tweets = Kaminari.paginate_array(selected_tweets).page(params[:page]).per(15) # HACK: 個別に設定を決めないようにする
  end
end
