class Director < ActiveRecord::Base
  has_many :episodes
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
