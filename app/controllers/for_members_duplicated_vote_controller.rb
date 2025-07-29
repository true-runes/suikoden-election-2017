class ForMembersDuplicatedVoteController < ApplicationController
  protect_from_forgery with: :null_session # HACK: よく勉強しないと危険
  include TweetsJoinUsers
  include SelectTweetsByHashtag
  include ForGetMethodAtMembers
  include ForPostMethodAtMembers

  layout 'application_members'

  def index
    authenticate_or_request_with_http_basic('Hello, gensosenkyo staff!') do |username, password|
      username == ENV['MEMBERS_PAGE_AUTH_USERNAME'] && password == ENV['MEMBERS_PAGE_AUTH_PASSWORD']
    end

    for_get_method if request.get?
    for_post_method(params[:search_word]) if request.post?
  end

  def for_get_method # rubocop:disable Metrics/AbcSize
    tomochin = without_retweets_and_gensosenkyo_loose_limited_period # Array
    selected_tomochin = select_tweets_by_hashtag(tomochin, '幻水総選挙2017投票', '幻水総選挙2017')

    # まずは削除済みツイートを取り除くところから
    # TODO: コントローラに詰め込みすぎだし NOT DRY
    unreadable_tweet_ids = IsReadableTweet.where(is_readable: false)
    @removed_tweet_ids = []
    unreadable_tweet_ids.each do |tweet|
      @removed_tweet_ids << tweet.tweet_id
    end

    # 削除済みツイートを取り除く
    tomochan = selected_tomochin.reject do |element|
      @removed_tweet_ids.include?(element.tweet_id)
    end

    tomochan_hash = tomochan.map(&:attributes)
    @target_screen_names = []
    tomochan_hash.each do |record|
      @target_screen_names << record['screen_name']
    end

    @result_1st = []
    @target_screen_names.each do |screen_name|
      if @target_screen_names.count(screen_name) >= 2
        @result_1st << screen_name # この screen_name がやばいということ
      end
    end

    tomotomochin = without_retweets_and_gensosenkyo_loose_limited_period_name_sort
    last_result_tweets = tomotomochin.select do |element| # reject の反対で、合致したら採用する
      @result_1st.include?(element.screen_name)
    end

    @kaminari_page_per = 20

    # HACK: 個別に設定を決めないようにする
    @kaminaried_tweets = Kaminari.paginate_array(last_result_tweets.reverse).page(params[:page]).per(@kaminari_page_per)
  end

  def for_post_method(search_word) # rubocop:disable Metrics/AbcSize
    tomochin = without_retweets_and_gensosenkyo_loose_limited_period # Array
    selected_tomochin = select_tweets_by_hashtag(tomochin, '幻水総選挙2017投票', '幻水総選挙2017')

    # まずは削除済みツイートを取り除くところから
    # TODO: コントローラに詰め込みすぎだし NOT DRY
    unreadable_tweet_ids = IsReadableTweet.where(is_readable: false)
    @removed_tweet_ids = []
    unreadable_tweet_ids.each do |tweet|
      @removed_tweet_ids << tweet.tweet_id
    end

    # 削除済みツイートを取り除く
    tomochan = selected_tomochin.reject do |element|
      @removed_tweet_ids.include?(element.tweet_id)
    end

    tomochan_hash = tomochan.map(&:attributes)
    @target_screen_names = []
    tomochan_hash.each do |record|
      @target_screen_names << record['screen_name']
    end

    @result_1st = []
    @target_screen_names.each do |screen_name|
      if @target_screen_names.count(screen_name) >= 2
        @result_1st << screen_name # この screen_name がやばいということ
      end
    end

    tomotomochin = without_retweets_and_gensosenkyo_loose_limited_period_name_sort
    last_result_tweets = tomotomochin.select do |element| # reject の反対で、合致したら採用する
      @result_1st.include?(element.screen_name)
    end

    # この時点で last_result_tweets は Array（Tweet であり ActiveRecord ではない）
    @lastest_result_tweets = []
    last_result_tweets.select do |element|
      @lastest_result_tweets << element if /.*#{search_word}.*/.match?(element.text)
    end

    @kaminari_page_per = 20

    # HACK: 個別に設定を決めないようにする
    @kaminaried_tweets = Kaminari
                         .paginate_array(@lastest_result_tweets.reverse)
                         .page(params[:page])
                         .per(@kaminari_page_per)
  end
end
