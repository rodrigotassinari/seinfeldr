class Episode < ActiveRecord::Base
  belongs_to :season
  
  belongs_to :director
  
  has_and_belongs_to_many :writers
  
  has_many :winning_votes, 
    :class_name => 'Vote', 
    :foreign_key => 'winner_id'
  
  has_many :losing_votes, 
    :class_name => 'Vote', 
    :foreign_key => 'loser_id'
  
  has_many :votes,
    :class_name => 'Vote', 
    :finder_sql => 'SELECT * FROM votes WHERE (winner_id = #{id} OR loser_id = #{id})'
  
  validates_presence_of :season_id, :director_id, :title, :airdate, :production_code, :season_number, :series_number, :wikipedia_entry_url
  validates_uniqueness_of :title, :production_code
  
  after_create :increment_episodes_count
  after_destroy :decrement_episodes_count
  
  named_scope :ordered,
    :order => 'episodes.airdate ASC'
  named_scope :ranked,
    :order => 'episodes.rank DESC, episodes.total_votes_share DESC, episodes.total_votes_count DESC'
  named_scope :top,
    :conditions => ['episodes.total_votes_count >= ? OR episodes.total_votes_count >= ?', (Vote.count.to_f / Episode.count), 50]
  named_scope :included,
    :include => [:season, :director, :writers]

  def self.random_pair
    eps = Episode.all(
      :include => [:season, :director, :writers],
      :order => "RAND()",
      :limit => 2
    )
    eps.size == 2 ? eps : []
  end

  def recalculate_votes_share!(votes_count=nil)
    votes_count ||= Vote.count
    new_vote_share = (self.total_votes_count / votes_count.to_f)
    self.update_attribute(:total_votes_share, new_vote_share)
  end

  def self.recalculate_votes_share!
    episodes = Episode.all
    votes_count = Vote.count
    episodes.each do |episode|
      episode.recalculate_votes_share!(votes_count)
    end
  end
  
  protected
  
    # after_create
    def increment_episodes_count
      self.director.increment!(:episodes_count)
      self.season.increment!(:episodes_count)
      self.writers.each { |writer| writer.increment!(:episodes_count) }
      true
    end
    
    # after_destroy
    def decrement_episodes_count
      self.director.decrement!(:episodes_count)
      self.season.decrement!(:episodes_count)
      self.writers.each { |writer| writer.decrement!(:episodes_count) }
      true
    end
    
end
