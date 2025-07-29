class ForMembersCheckVoteController < ApplicationController
  protect_from_forgery with: :null_session # HACK: よく勉強しないと危険
  include TweetsJoinUsers
  include SelectTweetsByHashtag
  include ForGetMethodAtMembers
  include ForPostMethodAtMembers

  layout 'application_members'
  # before_action :site_http_basic_authenticate_with

  def show # rubocop:disable Metrics/AbcSize
    authenticate_or_request_with_http_basic('Hello, gensosenkyo staff!') do |username, password|
      username == ENV['MEMBERS_PAGE_AUTH_USERNAME'] && password == ENV['MEMBERS_PAGE_AUTH_PASSWORD']
    end

    @screen_name = params[:search_tw_id].nil? ? '' : params[:search_tw_id].gsub(/@/, '')
    source_tweets = tweets_by_specific_user(@screen_name)

    # TODO: コントローラに詰め込みすぎ
    unreadable_tweet_ids = IsReadableTweet.where(is_readable: false)
    @removed_tweet_ids = []
    unreadable_tweet_ids.each do |tweet|
      @removed_tweet_ids << tweet.tweet_id
    end

    last_result_tweets = source_tweets.reject do |element|
      @removed_tweet_ids.include?(element.tweet_id)
    end

    @kaminari_page_per = 20

    # HACK: 個別に設定を決めないようにする
    @kaminaried_tweets = Kaminari.paginate_array(last_result_tweets.reverse).page(params[:page]).per(@kaminari_page_per)
  end

  def result # rubocop:disable Metrics/AbcSize
    authenticate_or_request_with_http_basic('Hello, gensosenkyo staff!') do |username, password|
      username == ENV['MEMBERS_PAGE_AUTH_USERNAME'] && password == ENV['MEMBERS_PAGE_AUTH_PASSWORD']
    end

    @screen_name = params[:search_tw_id].nil? ? '' : params[:search_tw_id].gsub(/@/, '')
    source_tweets = tweets_by_specific_user(@screen_name)

    # TODO: コントローラに詰め込みすぎ
    unreadable_tweet_ids = IsReadableTweet.where(is_readable: false)
    @removed_tweet_ids = []
    unreadable_tweet_ids.each do |tweet|
      @removed_tweet_ids << tweet.tweet_id
    end

    last_result_tweets = source_tweets.reject do |element|
      @removed_tweet_ids.include?(element.tweet_id)
    end

    @kaminari_page_per = 20

    # HACK: 個別に設定を決めないようにする
    @kaminaried_tweets = Kaminari.paginate_array(last_result_tweets.reverse).page(params[:page]).per(@kaminari_page_per)
  end
end
