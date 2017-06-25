class CountVoteController < ApplicationController
  protect_from_forgery with: :null_session # HACK: よく勉強しないと危険
  include TweetsJoinUsers
  include SelectTweetsByHashtag
  include ForGetMethodAtMembers
  include ForPostMethodAtMembers
  # layout 'application_members'
  # before_action :site_http_basic_authenticate_with

  # def site_http_basic_authenticate_with
  #   authenticate_or_request_with_http_basic("Hello, gensosenkyo staff!") do |username, password|
  #     username == Rails.application.secrets.members_page_auth_username && password == Rails.application.secrets.members_page_auth_password
  #   end
  # end

  def index
    # show_vote_result if request.get?
    # show_vote_result_with_search(params[:search_word]) if request.post?
    show_count_vote_tweet if request.get?
    # show_vote_result_with_search(params[:search_word]) if request.post?
  end

  private
  # hyper dirty code...
  def show_count_vote_tweet
    # source_tweets = without_retweets_and_gensosenkyo_loose_limited_period
    # selected_tweets = select_tweets_by_hashtag(source_tweets, "幻水総選挙2017投票")
    source_tweets = tweets_by_specific_user_limited_count_vote_period("gensosenkyo")
    result_tweets = source_tweets

    # TODO: コントローラに詰め込みすぎ
    # unreadable_tweet_ids = IsReadableTweet.where(is_readable: false)
    # @removed_tweet_ids = []
    # unreadable_tweet_ids.each do |tweet|
    #   @removed_tweet_ids << tweet.tweet_id
    # end
    #
    # result_tweets = selected_tweets.reject do |element|
    #   @removed_tweet_ids.include?(element.tweet_id)
    # end

    @kaminari_page_per = 20
    @kaminaried_tweets = Kaminari.paginate_array(result_tweets.reverse).page(params[:page]).per(@kaminari_page_per) # HACK: 個別に設定を決めないようにする
  end
end
