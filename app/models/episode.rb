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
  
  after_save :increment_episodes_count
  after_destroy :decrement_episodes_count
  
  protected
  
    # after_save
    def increment_episodes_count
      self.director.increment!(:episodes_count)
      self.season.increment!(:episodes_count)
      self.writers.each { |w| w.increment!(:episodes_count) }
      true
    end
    
    # after_destroy
    def decrement_episodes_count
      self.director.decrement!(:episodes_count)
      self.season.decrement!(:episodes_count)
      self.writers.each { |w| w.decrement!(:episodes_count) }
      true
    end
    
end
