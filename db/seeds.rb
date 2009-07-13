require 'open-uri'

WP_EPISODE_LIST = "http://en.wikipedia.org/wiki/List_of_seinfeld_episodes"
WP_SEASON_1 = "http://en.wikipedia.org/wiki/Seinfeld_%28season_1%29"
WP_SEASON_2 = "http://en.wikipedia.org/wiki/Seinfeld_%28season_2%29"
WP_SEASON_3 = "http://en.wikipedia.org/wiki/Seinfeld_%28season_3%29"
WP_SEASON_4 = "http://en.wikipedia.org/wiki/Seinfeld_%28season_4%29"
WP_SEASON_5 = "http://en.wikipedia.org/wiki/Seinfeld_%28season_5%29"
WP_SEASON_6 = "http://en.wikipedia.org/wiki/Seinfeld_%28season_6%29"
WP_SEASON_7 = "http://en.wikipedia.org/wiki/Seinfeld_%28season_7%29"
WP_SEASON_8 = "http://en.wikipedia.org/wiki/Seinfeld_%28season_8%29"
WP_SEASON_9 = "http://en.wikipedia.org/wiki/Seinfeld_%28season_9%29"

def build_seasons
  Season.create!(:number => 1, :name => "Season 1: 1989-90", :wikipedia_entry_url => WP_SEASON_1)
  Season.create!(:number => 2, :name => "Season 2: 1991",    :wikipedia_entry_url => WP_SEASON_2)
  Season.create!(:number => 3, :name => "Season 3: 1991-92", :wikipedia_entry_url => WP_SEASON_3)
  Season.create!(:number => 4, :name => "Season 4: 1992-93", :wikipedia_entry_url => WP_SEASON_4)
  Season.create!(:number => 5, :name => "Season 5: 1993-94", :wikipedia_entry_url => WP_SEASON_5)
  Season.create!(:number => 6, :name => "Season 6: 1994-95", :wikipedia_entry_url => WP_SEASON_6)
  Season.create!(:number => 7, :name => "Season 7: 1995-96", :wikipedia_entry_url => WP_SEASON_7)
  Season.create!(:number => 8, :name => "Season 8: 1996-97", :wikipedia_entry_url => WP_SEASON_8)
  Season.create!(:number => 9, :name => "Season 9: 1997-98", :wikipedia_entry_url => WP_SEASON_9)
end

def build_directors
  directors = []
  doc = Hpricot(open(WP_EPISODE_LIST))
  season_tables = (doc/"table.wikitable.sortable")
  season_tables.each do |season_table|
    (season_table/"tr.vevent").each do |episode_row|
      directors << (episode_row/"td")[2].inner_text
    end
  end
  directors.sort!.uniq!
  puts "#{directors.size} directors loaded"
  directors.each do |director|
    Director.create!(:name => director)
    puts "Director #{director} created"
  end
end

def build_writers
  writers = []
  doc = Hpricot(open(WP_EPISODE_LIST))
  season_tables = (doc/"table.wikitable.sortable")
  season_tables.each do |season_table|
    (season_table/"tr.vevent").each do |episode_row|
      writers += (episode_row/"td")[3].inner_text.gsub(" and ", " & ").gsub(", ", " & ").split(" & ")
    end
  end
  writers.sort!.uniq!
  puts "#{writers.size} writers loaded"
  writers.each do |writer|
    Writer.create!(:name => writer)
    puts "Writer #{writer} created"
  end
end

def build_episodes
  episodes = []
  seasons = Season.all
  seasons.each do |season|
    doc = Hpricot(open(season.wikipedia_entry_url))
    episodes_table = (doc/"table.wikitable").last
    
    (episodes_table/"tr:first").remove
    (episodes_table/"tr > td[@colspan='9']").remove
    
    tr_count = (episodes_table/"tr").size
    td_count = (episodes_table/"td").size
    
    episode_count = (tr_count / 2)
    
    (0..td_count-1).enum_slice(8).each do |ep|
      ep_data1 = (episodes_table/"td")[ ep[0], ep[7] ]
      ep_data2 = (episodes_table/"td")[ ep[7] ]
      episodes << build_episode_hash(season, ep_data1, ep_data2)
    end

  end
  puts "#{episodes.size} episodes loaded"
  episodes.each do |episode_params|
    Episode.create!(episode_params)
  end
end

def build_episode_hash(season, ep_data1, ep_data2)
  episode = {}
  director = ep_data1[1].inner_text
  puts "Season #{season.id}, Episode #{ep_data1[4].inner_text} loaded"
  ep_director = Director.find_by_name!(director).id
  
  writers = ep_data1[2].inner_text.gsub(" and ", " & ").gsub(", ", " & ").split(" & ")
  ep_writers = Writer.find_all_by_name(writers).map(&:id)
  
  url = ep_data1[0].at("a").attributes['href']
  url = "http://en.wikipedia.org#{url}" if url.first == '/'
  ep_url = url
  
  episode[:season_id] = season.id
  episode[:director_id] = ep_director
  episode[:writer_ids] = ep_writers
  episode[:title] = ep_data1[0].at("a").inner_text
  episode[:airdate] = ep_data1[3].inner_text.to_date
  episode[:production_code] = ep_data1[4].inner_text.to_i
  episode[:season_number] = ep_data1[5].inner_text.to_i
  episode[:series_number] = ep_data1[6].inner_text.to_i
  episode[:wikipedia_entry_url] = ep_url
  episode[:summary] = ep_data2.inner_text.gsub("\n", "").chomp
  
  episode
end

build_seasons
build_directors
build_writers
build_episodes

