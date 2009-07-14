require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe VotesController do

  #Delete these examples and add some real ones
  it "should use VotesController" do
    controller.should be_an_instance_of(VotesController)
  end


  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end
end
