require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Vote do
  before(:each) do
    @valid_attributes = {
      :winner_id => 1,
      :loser_id => 1,
      :created_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Vote.create!(@valid_attributes)
  end
end
