class CreateTwitterUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :twitter_users do |t|
      t.integer :uid, unique: true
      t.string :name
      t.string :owner, null: false, unique: true
      t.string :image_url

      t.timestamps
    end
  end
end
