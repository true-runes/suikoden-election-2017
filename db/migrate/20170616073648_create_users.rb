class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :screen_name
      t.string :name
      t.string :profile_image_uri
      t.boolean :is_protected

      t.timestamps
    end
    add_index :users, :user_id, unique: true
  end
end
