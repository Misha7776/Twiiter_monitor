class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string :full_text
      t.datetime :created
      t.integer :retweet_count
      t.integer :favorite_count
      t.string :uri

      t.timestamps
      t.references :twitter_user, foreign_key: true
    end
  end
end
