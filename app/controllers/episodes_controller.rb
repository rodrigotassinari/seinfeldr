class EpisodesController < ApplicationController

  # GET /:locale/episodes
  def index
    @page_title = t(:top_seinfeld_episodes)
    @episodes = Episode.top.ranked.included.paginate(:page => params[:page], :per_page => 10)
  end
  
  # GET /:locale/episodes/:id
  def show
    @episode = Episode.find(params[:id])
    @page_title = "#{@episode.season.number}x#{@episode.season_number} - #{@episode.title}"
  end
  
end
