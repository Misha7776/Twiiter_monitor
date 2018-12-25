class AddSidekiqJobIdToTwitterUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :twitter_users, :job_id, :integer
  end
end
