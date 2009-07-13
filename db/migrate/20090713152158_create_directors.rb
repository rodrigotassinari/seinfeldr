class CreateDirectors < ActiveRecord::Migration
  def self.up
    create_table :directors do |t|
      t.string  :name
      t.integer :episodes_count,      :default => 0
      t.integer :winning_votes_count, :default => 0
      t.integer :losing_votes_count,  :default => 0
      t.integer :total_votes_count,   :default => 0
      t.float   :total_votes_share,   :default => 0.0
      t.integer :rank,                :default => 0
      t.timestamps
    end
    add_index :directors, :total_votes_share
    add_index :directors, :rank
  end

  def self.down
    drop_table :directors
  end
end
