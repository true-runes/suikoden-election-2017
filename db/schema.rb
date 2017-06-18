# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170618110332) do

  create_table "attached_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "tweet_id"
    t.string "media_id"
    t.string "uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_id"], name: "index_attached_images_on_media_id", unique: true
  end

  create_table "hashtags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "tweet_id"
    t.string "tagname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id", "tagname"], name: "index_hashtags_on_tweet_id_and_tagname", unique: true
  end

  create_table "is_readable_tweets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "tweet_id"
    t.boolean "is_readable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "tweet_id"
    t.string "user_id"
    t.string "text"
    t.string "full_text"
    t.string "uri"
    t.datetime "tweeted_at"
    t.boolean "is_retweet"
    t.boolean "is_attached_image"
    t.boolean "has_hashtag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id"], name: "index_tweets_on_tweet_id", unique: true
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "user_id"
    t.string "screen_name"
    t.string "name"
    t.string "profile_image_uri"
    t.boolean "is_protected"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_users_on_user_id", unique: true
  end

end
