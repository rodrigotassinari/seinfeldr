class VotesController < ApplicationController

  # GET /
  # GET /votes/new
  def new
    @page_title = nil
    @episodes = Episode.random_pair
  end

  # POST /votes
  def create
    winner, loser = Episode.find(params[:vote][:winner_id]), Episode.find(params[:vote][:loser_id])
    vote = Vote.new(:winner => winner, :loser => loser)
    if vote.save
      flash[:success] = "Vote sucessfully created"
    else
      flash[:error] = "Invalid vote"
    end
    redirect_to locale_root_path
  end

end
