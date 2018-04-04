class AddUserIdToTwitterUsersTable < ActiveRecord::Migration[5.1]
  def change
    add_reference :twitter_users, :user, foreign_key: true
  end
end
