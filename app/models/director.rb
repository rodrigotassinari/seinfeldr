class Director < ActiveRecord::Base
  has_many :episodes
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  named_scope :ordered,
    :order => 'directors.name ASC'
  named_scope :ranked,
    :order => 'directors.rank DESC, directors.total_votes_share DESC, directors.total_votes_count DESC'
  
end
