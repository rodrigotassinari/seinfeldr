require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Episode do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :summary => "value for summary",
      :director_id => 1,
      :airdate => Date.today,
      :production_code => 1,
      :season_id => 1,
      :season_number => 1,
      :series_number => 1,
      :wikipedia_entry_url => "value for wikipedia_entry_url",
      :winning_votes_count => 1,
      :losing_votes_count => 1,
      :total_votes_count => 1,
      :total_votes_share => 1.5,
      :rank => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Episode.create!(@valid_attributes)
  end
end
