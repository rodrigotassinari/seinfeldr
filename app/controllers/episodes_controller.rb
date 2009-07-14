class EpisodesController < ApplicationController

  # GET /:locale/episodes
  def new
    @page_title = t(:top_seinfeld_episodes)
    @episodes = Episode.top.ranked.paginate(params[:page])
  end
  
  # GET /:locale/episodes/:id
  def show
    @episode = Episode.find(params[:id])
    @page_title = "#{@episode.season.number}x#{@episode.season_number} - #{@episode.title}"
  end
  
end

