class CountVoteController < ApplicationController
  protect_from_forgery with: :null_session # HACK: よく勉強しないと危険
  include TweetsJoinUsers
  include SelectTweetsByHashtag
  include ForGetMethodAtMembers
  include ForPostMethodAtMembers

  def index
    show_count_vote_tweet if request.get?
    # show_vote_result_with_search(params[:search_word]) if request.post?
  end

  private

  # hyper dirty code...
  def show_count_vote_tweet
    source_tweets = tweets_by_specific_user_limited_count_vote_period('gensosenkyo')
    result_tweets = source_tweets

    @kaminari_page_per = 10

    # HACK: 個別に設定を決めないようにする
    @kaminaried_tweets = Kaminari.paginate_array(result_tweets).page(params[:page]).per(@kaminari_page_per)
  end
end
