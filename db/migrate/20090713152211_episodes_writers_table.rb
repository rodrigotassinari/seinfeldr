class EpisodesWritersTable < ActiveRecord::Migration
  def self.up
    create_table :episodes_writers, :id => false do |t|
      t.integer :episode_id
      t.integer :writer_id
      t.timestamps
    end
  end

  def self.down
    drop_table :episodes_writers
  end
end
