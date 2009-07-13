require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Writer do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :episodes_count => 1,
      :winning_votes_count => 1,
      :losing_votes_count => 1,
      :total_votes_count => 1,
      :total_votes_share => 1.5,
      :rank => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Writer.create!(@valid_attributes)
  end
end
