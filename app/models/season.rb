class Season < ActiveRecord::Base
  has_many :episodes
  
  validates_presence_of :name, :number, :wikipedia_entry_url
  validates_uniqueness_of :name, :number, :wikipedia_entry_url
end
