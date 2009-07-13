class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer  :winner_id
      t.integer  :loser_id
      t.datetime :created_at
    end
    add_index :votes, :winner_id
    add_index :votes, :loser_id
    add_index :votes, :created_at
  end

  def self.down
    drop_table :votes
  end
end
