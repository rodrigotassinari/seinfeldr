class Writer < ActiveRecord::Base
  has_and_belongs_to_many :episodes
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  named_scope :ordered,
    :order => 'writers.name ASC'
  named_scope :ranked,
    :order => 'writers.rank DESC, writers.total_votes_share DESC, writers.total_votes_count DESC'
  
end
