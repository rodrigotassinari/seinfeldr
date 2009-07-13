class CreateWriters < ActiveRecord::Migration
  def self.up
    create_table :writers do |t|
      t.string  :name
      t.integer :episodes_count,      :default => 0
      t.integer :winning_votes_count, :default => 0
      t.integer :losing_votes_count,  :default => 0
      t.integer :total_votes_count,   :default => 0
      t.float   :total_votes_share,   :default => 0.0
      t.float   :rank,                :default => 0.0
      t.timestamps
    end
    add_index :writers, :total_votes_share
    add_index :writers, :rank
  end

  def self.down
    drop_table :writers
  end
end
