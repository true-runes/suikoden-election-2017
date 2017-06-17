class CreateAttachedImages < ActiveRecord::Migration[5.1]
  def change
    create_table :attached_images do |t|
      t.string :tweet_id
      t.integer :count
      t.string :uri

      t.timestamps
    end
  end
end
