class Vote < ActiveRecord::Base
  belongs_to :winner, 
    :class_name => 'Episode',
    :foreign_key => 'winner_id'
  belongs_to :loser,
    :class_name => 'Episode',
    :foreign_key => 'loser_id'
  
  validates_presence_of :winner_id, :loser_id
  
  def validate
    if winner_id == loser_id
      errors.add_to_base("Compared episodes must not be the same") # TODO traduzir
    end
  end
  
  after_create :increment_votes_count
  after_create :update_votes_share
  
  after_destroy :decrement_votes_count
  after_destroy :update_votes_share
  
  protected
  
    # after_create
    def increment_votes_count
      w, l = self.winner, self.loser
      
      w.increment!(:winning_votes_count)
      w.increment!(:total_votes_count)
      w.director.increment!(:winning_votes_count)
      w.director.increment!(:total_votes_count)
      w.season.increment!(:winning_votes_count)
      w.season.increment!(:total_votes_count)
      w.writers.each do |writer| 
        writer.increment!(:winning_votes_count)
        writer.increment!(:total_votes_count)
      end
      
      l.increment!(:losing_votes_count)
      l.increment!(:total_votes_count)
      l.director.increment!(:losing_votes_count)
      l.director.increment!(:total_votes_count)
      l.season.increment!(:losing_votes_count)
      l.season.increment!(:total_votes_count)
      l.writers.each do |writer| 
        writer.increment!(:losing_votes_count)
        writer.increment!(:total_votes_count)
      end
      
      true
    end
    
    # after_destroy
    def decrement_votes_count
      w, l = self.winner, self.loser
      
      w.decrement!(:winning_votes_count)
      w.decrement!(:total_votes_count)
      w.director.decrement!(:winning_votes_count)
      w.director.decrement!(:total_votes_count)
      w.season.decrement!(:winning_votes_count)
      w.season.decrement!(:total_votes_count)
      w.writers.each do |writer| 
        writer.decrement!(:winning_votes_count)
        writer.decrement!(:total_votes_count)
      end
      
      l.decrement!(:losing_votes_count)
      l.decrement!(:total_votes_count)
      l.director.decrement!(:losing_votes_count)
      l.director.decrement!(:total_votes_count)
      l.season.decrement!(:losing_votes_count)
      l.season.decrement!(:total_votes_count)
      l.writers.each do |writer| 
        writer.decrement!(:losing_votes_count)
        writer.decrement!(:total_votes_count)
      end
      
      true
    end
    
    # after_create & after_destroy
    def update_votes_share
      total_votes = Vote.count.to_f
      return true if total_votes == 0
      [self.winner, self.loser].each do |episode|
        ep_share = (episode.total_votes_count / total_votes)
        ep_director_share = (episode.director.total_votes_count / total_votes)
        ep_season_share = (episode.season.total_votes_count / total_votes)
        
        episode.update_attribute(:total_votes_share, ep_share)
        episode.director.update_attribute(:total_votes_share, ep_director_share)
        episode.season.update_attribute(:total_votes_share, ep_season_share)
        episode.writers.each do |writer| 
          writer_share = (writer.total_votes_count / total_votes)
          writer.update_attribute(:total_votes_share, writer_share)
        end
      end      
      true
    end
    
end
