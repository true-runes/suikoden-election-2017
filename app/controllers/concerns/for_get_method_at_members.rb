module ForGetMethodAtMembers
  def show_vote_result # rubocop:disable Metrics/AbcSize
    source_tweets = without_retweets_and_gensosenkyo_loose_limited_period
    selected_tweets = select_tweets_by_hashtag(source_tweets, '幻水総選挙2017投票')

    # TODO: コントローラに詰め込みすぎ
    unreadable_tweet_ids = IsReadableTweet.where(is_readable: false)
    @removed_tweet_ids = []
    unreadable_tweet_ids.each do |tweet|
      @removed_tweet_ids << tweet.tweet_id
    end

    result_tweets = selected_tweets.reject do |element|
      @removed_tweet_ids.include?(element.tweet_id)
    end

    @kaminari_page_per = 20

    # HACK: 個別に設定を決めないようにする
    @kaminaried_tweets = Kaminari.paginate_array(result_tweets.reverse).page(params[:page]).per(@kaminari_page_per)
  end

  def show_vote_result_after_party # rubocop:disable Metrics/AbcSize
    source_tweets = for_after_party
    selected_tweets = select_tweets_by_hashtag(source_tweets, '幻水総選挙2017後夜祭')

    # TODO: コントローラに詰め込みすぎ
    unreadable_tweet_ids = IsReadableTweet.where(is_readable: false)
    @removed_tweet_ids = []
    unreadable_tweet_ids.each do |tweet|
      @removed_tweet_ids << tweet.tweet_id
    end

    result_tweets = selected_tweets.reject do |element|
      @removed_tweet_ids.include?(element.tweet_id)
    end

    @kaminari_page_per = 20

    # HACK: 個別に設定を決めないようにする
    @kaminaried_tweets = Kaminari.paginate_array(result_tweets.reverse).page(params[:page]).per(@kaminari_page_per)
  end
end
