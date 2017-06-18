class ForMembersController < ApplicationController
  include TweetsJoinUsers
  include SelectTweetsByHashtag

  def index
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.secrets.members_page_auth_username && password == Rails.application.secrets.members_page_auth_password
    end
    source_tweets = without_retweets
    # source_tweets = without_retweets_and_limited_period
    selected_tweets = select_tweets_by_hashtag(source_tweets, "幻水総選挙2017投票")
    @kaminaried_tweets = Kaminari.paginate_array(selected_tweets).page(params[:page]).per(15) # HACK: 個別に設定を決めないようにする
  end
end
