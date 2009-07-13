class CreateEpisodes < ActiveRecord::Migration
  def self.up
    create_table :episodes do |t|
      t.integer :director_id
      t.integer :season_id
      t.string  :title
      t.text    :summary
      t.date    :airdate
      t.integer :production_code
      t.integer :season_number
      t.integer :series_number
      t.string  :wikipedia_entry_url
      t.integer :winning_votes_count, :default => 0
      t.integer :losing_votes_count,  :default => 0
      t.integer :total_votes_count,   :default => 0
      t.float   :total_votes_share,   :default => 0.0
      t.integer :rank,                :default => 0
      t.timestamps
    end
    add_index :episodes, :director_id
    add_index :episodes, :season_id
    add_index :episodes, :total_votes_share
    add_index :episodes, :rank
  end

  def self.down
    drop_table :episodes
  end
end
