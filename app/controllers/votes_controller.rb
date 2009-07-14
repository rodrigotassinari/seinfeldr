class VotesController < ApplicationController

  # GET /
  # GET /:locale
  # GET /:locale/votes/new
  def new
    @page_title = nil
    @episodes = Episode.random_pair
  end

  # POST /:locale/votes
  def create
    winner, loser = Episode.find(params[:vote][:winner_id]), Episode.find(params[:vote][:loser_id])
    vote = Vote.new(:winner => winner, :loser => loser)
    if vote.save
      flash[:success] = t(:vote_created)
    else
      flash[:error] = t(:vote_not_created)
    end
    redirect_to locale_root_path
  end

end
