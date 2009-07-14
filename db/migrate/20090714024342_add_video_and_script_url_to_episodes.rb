class AddVideoAndScriptUrlToEpisodes < ActiveRecord::Migration
  def self.up
    add_column :episodes, :seinfeldx_entry_url, :string
    add_column :episodes, :seinfeldscripts_entry_url, :string
  end

  def self.down
    remove_column :episodes, :seinfeldx_entry_url
    remove_column :episodes, :seinfeldscripts_entry_url
  end
end
