# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2017_06_18_140954) do

  create_table "attached_images", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "tweet_id"
    t.string "media_id"
    t.string "uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_id"], name: "index_attached_images_on_media_id", unique: true
  end

  create_table "hashtags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "tweet_id"
    t.string "tagname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id", "tagname"], name: "index_hashtags_on_tweet_id_and_tagname", unique: true
  end

  create_table "is_readable_tweets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "tweet_id"
    t.boolean "is_readable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id"], name: "index_is_readable_tweets_on_tweet_id", unique: true
  end

  create_table "tweets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
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

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
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
