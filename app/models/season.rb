class Season < ActiveRecord::Base
  has_many :episodes
  
  validates_presence_of :name, :number, :wikipedia_entry_url
  validates_uniqueness_of :name, :number, :wikipedia_entry_url
  
  named_scope :ordered,
    :order => 'seasons.number ASC'
  named_scope :ranked,
    :order => 'seasons.rank DESC, seasons.total_votes_share DESC, seasons.total_votes_count DESC'
  
end
