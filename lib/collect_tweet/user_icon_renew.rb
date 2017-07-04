class SuikodenElection2017Tweets
  require 'bundler/setup'
  require 'twitter'
  require 'active_record'
  require 'mysql2'
  require 'yaml'

  def client
    @client = Twitter::REST::Client.new do |config|
      twitter_api_config = YAML.load_file('config/secrets.yml')
      config.consumer_key        = twitter_api_config["shared"]["twitter_consumer_key"]
      config.consumer_secret     = twitter_api_config["shared"]["twitter_consumer_secret"]
      config.access_token        = twitter_api_config["shared"]["twitter_access_token"]
      config.access_token_secret = twitter_api_config["shared"]["twitter_access_token_secret"]
    end
  end

  config = YAML.load_file('config/database.yml')
  ActiveRecord::Base.establish_connection(config["development"])
  class Tweet < ActiveRecord::Base
  end
  class User < ActiveRecord::Base
  end
  class AttachedImage < ActiveRecord::Base
  end
  class Hashtag < ActiveRecord::Base
  end
  class IsReadableTweet < ActiveRecord::Base
  end

  # HACK: limit(1)っていう取得のメソッドじゃなくてちゃんとメソッドがあるので直す（NOT DRY でイケてない）
  def get_since_id
    if Tweet.order("tweet_id desc").limit(1).empty? # HACK: magic number
      since_id = "1" # 2週間制限があるから実質的にほとんど意味はない定義
    else
      since_id = Tweet.order("tweet_id desc").limit(1)[0].tweet_id
    end
  end

  # HACK: limit(1)っていう取得のメソッドじゃなくてちゃんとメソッドがあるので直す（NOT DRY でイケてない）
  def get_max_id
    max_id = Tweet.order("tweet_id asc").limit(1)[0].tweet_id unless Tweet.order("tweet_id asc").limit(1).empty?
  end

  def tweets_by_hashtag(hashtag, take_amount=200, since_id=get_since_id)
    # since_id = "1234567890"
    tweets = @client.search(hashtag, { since_id: since_id }).take(take_amount)
    if tweets.empty?
    end
    tweets
  end

  # 後ろにたどるの場合は初期取得のときと、総チェック（ユーザ情報（ここはメソッド分けたい）やツイートの有無）のとき
  def back_tweets_by_hashtag(hashtag, take_amount=200, max_id=get_max_id)
    # max_id = "1234567890"
    tweets = @client.search(hashtag, { max_id: max_id }).take(take_amount)
    if tweets.empty?
    end
    tweets
  end

  def attached_image_attrs(tweet)
    @attached_image_attrs = []
    tweet.media.each do |each_media|
      @attached_image_attrs << { media_id: each_media.id, uri: each_media.media_url_https.to_s }
    end
    @attached_image_attrs
  end

  def hashtag_attrs(tweet)
    @hashtag_attrs = []
    tweet.hashtags.each do |each_hash|
      @hashtag_attrs << { hashtag: each_hash.text }
    end
    @hashtag_attrs
  end

  def protected_user?(screen_name)
    @client.user_timeline(screen_name, { count: 1 })
  rescue Twitter::Error::Unauthorized
    true
  else
    false
  end

  # データベースに書き込む
  def create_record_to_tweets(tweet)
    unless Tweet.exists?(tweet_id: tweet.id) # HACK: UPSERT の方法を再検討
      Tweet.create(
        tweet_id: tweet.id,
        user_id: tweet.user.id,
        text: tweet.text,
        full_text: tweet.full_text,
        uri: tweet.uri,
        tweeted_at: tweet.created_at,
        is_retweet: tweet.retweet?,
        is_attached_image: tweet.media?,
        has_hashtag: tweet.hashtags?,
      )
    end
  end

  def create_record_to_users(tweet)
    user = tweet.user
    profile_image_uri = user.profile_image_uri? ? user.profile_image_uri_https : "https://abs.twimg.com/sticky/default_profile_images/default_profile.png"
    if User.exists?(user_id: user.id) # HACK: UPSERT の方法を再検討
      usr = User.where(user_id: user.id).first
      usr.update_attribute(
        profile_image_uri: profile_image_uri,
      )
    else
      User.create(
        user_id: user.id,
        screen_name: user.screen_name,
        name: user.name,
        profile_image_uri: profile_image_uri, # HACK: { size: 'original' }?
        is_protected: protected_user?(user.screen_name),
      )
    end
  end

  def create_record_to_hashtags(tweet)
    attrs = hashtag_attrs(tweet)
    attrs.each do |attr|
      unless Hashtag.where(tweet_id: tweet.id, tagname: attr[:hashtag]).exists? # HACK: UPSERT の方法を再検討
        Hashtag.create(
          tweet_id: tweet.id,
          tagname: attr[:hashtag],
        )
      end
    end
  end

  def create_record_to_attached_images(tweet)
    attrs = attached_image_attrs(tweet)
    attrs.each do |attr|
      # unless AttachedImage.where(media_id: attr[:media_id]).exists? # HACK: UPSERT の方法を再検討
        AttachedImage.create(
          tweet_id: tweet.id,
          media_id: attr[:media_id],
          uri: attr[:uri],
        )
      # end
    end
  end

  def create_record_to_is_readable_tweets
    # TODO: writing...
  end

  def create_record_to_all_tables(tweet)
    create_record_to_tweets(tweet)
    create_record_to_users(tweet)
    create_record_to_hashtags(tweet) if tweet.hashtags?
    create_record_to_attached_images(tweet) if tweet.media?
  end

  def create_record_by_hashtag(hashtag, take_amount=200, since_id=get_since_id)
    tweets = tweets_by_hashtag(hashtag, take_amount, since_id)
    tweets.each do |tweet|
      create_record_to_all_tables(tweet)
    end
  end

  def back_create_record_by_hashtag(hashtag, take_amount=200, max_id=get_max_id)
    tweets = back_tweets_by_hashtag(hashtag, take_amount, max_id)
    tweets.each do |tweet|
      create_record_to_all_tables(tweet)
    end
  end

  def collect_tweet
    client
    create_record_by_hashtag("#幻水総選挙2017投票 OR #幻水総選挙2017 OR #幻水総選挙 OR #幻水総選挙運動 OR #幻水総選挙2017後夜祭")
    # back_create_record_by_hashtag("#幻水総選挙2017投票 OR #幻水総選挙2017 OR #幻水総選挙 OR #幻水総選挙運動")
  end

  def tweet_by_id(id)
    client
    tweet = @client.status(id)
  end

  def get_users
    users = User.find_by_sql([%Q{SELECT * FROM users ORDER BY id ASC}])
  end

  # puts @client.user?(users[0].user_id.to_i)
  def muriyari_update
    client
    users = get_users

    users.each_with_index do |user, i|
      next unless @client.user?((user.user_id).to_i)
      latest_user_image_uri = latest_user_image_uri((user.user_id).to_i)

      user.update_attribute(
        :profile_image_uri, latest_user_image_uri
      )

      if (i + 1) % 30 == 0
        sleep(60)
      end
    end
  end

  def latest_user_image_uri(user_id)
    user = @client.user(user_id)
    user.profile_image_uri_https
  end
end

obj = SuikodenElection2017Tweets.new
obj.muriyari_update

# puts obj.get_users[0].user_id
# puts obj.muriyari_update.profile_image_uri
# puts obj.muriyari_update.profile_image_uri

# tweet = obj.tweet_by_id("878921012213014529")
# puts tweet.user.id
# obj.create_record_to_users(tweet)

####
#### puts obj.tweet_by_user.profile_image_uri_https
# puts obj.latest_usr_img("harck108")
