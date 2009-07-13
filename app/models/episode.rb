class Episode < ActiveRecord::Base
  belongs_to :season
  belongs_to :director
  has_and_belongs_to_many :writers
  
  validates_presence_of :season_id, :director_id, :title, :airdate, :production_code, :season_number, :series_number, :wikipedia_entry_url
  validates_uniqueness_of :title, :production_code
end
