class CreateSeasons < ActiveRecord::Migration
  def self.up
    create_table :seasons do |t|
      t.integer :number
      t.string  :name
      t.string  :wikipedia_entry_url
      t.integer :episodes_count,      :default => 0
      t.integer :winning_votes_count, :default => 0
      t.integer :losing_votes_count,  :default => 0
      t.integer :total_votes_count,   :default => 0
      t.float   :total_votes_share,   :default => 0.0
      t.float   :rank,                :default => 0.0
      t.timestamps
    end
    add_index :seasons, :total_votes_share
    add_index :seasons, :rank
  end

  def self.down
    drop_table :seasons
  end
end
