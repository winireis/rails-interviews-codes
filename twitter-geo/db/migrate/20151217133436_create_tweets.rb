class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.bigint :tweet_id
      t.string :nickname
      t.string :content
      t.integer :char_length
      t.integer :word_length
      t.string :city
      t.string :country
      t.datetime :created_at
    end
    add_index :tweets, :tweet_id
    add_index :tweets, :nickname
    add_index :tweets, :city
    add_index :tweets, :country
    add_index :tweets, :created_at
  end
end
