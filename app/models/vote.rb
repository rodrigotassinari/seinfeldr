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
  after_create :update_votes_share_and_rank
  
  after_destroy :decrement_votes_count
  after_destroy :update_votes_share_and_rank
  
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
        writer2 = Writer.find(writer.id)
        writer2.increment!(:winning_votes_count)
        writer2.increment!(:total_votes_count)
      end
      
      l.increment!(:losing_votes_count)
      l.increment!(:total_votes_count)
      l.director.increment!(:losing_votes_count)
      l.director.increment!(:total_votes_count)
      l.season.increment!(:losing_votes_count)
      l.season.increment!(:total_votes_count)
      l.writers.each do |writer|
        writer2 = Writer.find(writer.id)
        writer2.increment!(:losing_votes_count)
        writer2.increment!(:total_votes_count)
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
        writer2 = Writer.find(writer.id)
        writer2.decrement!(:winning_votes_count)
        writer2.decrement!(:total_votes_count)
      end
      
      l.decrement!(:losing_votes_count)
      l.decrement!(:total_votes_count)
      l.director.decrement!(:losing_votes_count)
      l.director.decrement!(:total_votes_count)
      l.season.decrement!(:losing_votes_count)
      l.season.decrement!(:total_votes_count)
      l.writers.each do |writer|
        writer2 = Writer.find(writer.id)
        writer2.decrement!(:losing_votes_count)
        writer2.decrement!(:total_votes_count)
      end
      
      true
    end
    
    # after_create & after_destroy
    def update_votes_share_and_rank
      total_votes = Vote.count.to_f
      return true if total_votes == 0
      [self.winner, self.loser].each do |episode|
        ep_share = (episode.total_votes_count / total_votes)
        ep_rank = ( episode.total_votes_count > 0 ? (episode.winning_votes_count.to_f / episode.total_votes_count) : 0.0 )
        
        ep_director_share = (episode.director.total_votes_count / total_votes)
        ep_director_rank = ( episode.director.total_votes_count > 0 ? (episode.director.winning_votes_count.to_f / episode.director.total_votes_count) : 0.0 )
        
        ep_season_share = (episode.season.total_votes_count / total_votes)
        ep_season_rank = ( episode.season.total_votes_count > 0 ? (episode.season.winning_votes_count.to_f / episode.season.total_votes_count) : 0.0 )
        
        episode.update_attribute(:total_votes_share, ep_share)
        episode.update_attribute(:rank, ep_rank)
        
        episode.director.update_attribute(:total_votes_share, ep_director_share)
        episode.director.update_attribute(:rank, ep_director_rank)
        
        episode.season.update_attribute(:total_votes_share, ep_season_share)
        episode.season.update_attribute(:rank, ep_season_rank)
        
        episode.writers.each do |writer|
          writer2 = Writer.find(writer.id)
          writer_share = (writer2.total_votes_count / total_votes)
          writer_rank = ( writer2.total_votes_count > 0 ? (writer2.winning_votes_count.to_f / writer2.total_votes_count) : 0.0 )
          
          writer2.update_attribute(:total_votes_share, writer_share)
          writer2.update_attribute(:rank, writer_rank)
        end
      end
      
      true
    end
    
end
