class AddColumnsToTwitterUser < ActiveRecord::Migration[5.1]
  def change
    add_column :twitter_users, :followers, :integer
    add_column :twitter_users, :following, :integer
    add_column :twitter_users, :created_at_twitter, :datetime
    add_column :twitter_users, :description, :string
  end
end
