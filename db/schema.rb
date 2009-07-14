# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090714024342) do

  create_table "directors", :force => true do |t|
    t.string   "name"
    t.integer  "episodes_count",      :default => 0
    t.integer  "winning_votes_count", :default => 0
    t.integer  "losing_votes_count",  :default => 0
    t.integer  "total_votes_count",   :default => 0
    t.float    "total_votes_share",   :default => 0.0
    t.float    "rank",                :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "directors", ["rank"], :name => "index_directors_on_rank"
  add_index "directors", ["total_votes_share"], :name => "index_directors_on_total_votes_share"

  create_table "episodes", :force => true do |t|
    t.integer  "director_id"
    t.integer  "season_id"
    t.string   "title"
    t.text     "summary"
    t.date     "airdate"
    t.integer  "production_code"
    t.integer  "season_number"
    t.integer  "series_number"
    t.string   "wikipedia_entry_url"
    t.integer  "winning_votes_count",       :default => 0
    t.integer  "losing_votes_count",        :default => 0
    t.integer  "total_votes_count",         :default => 0
    t.float    "total_votes_share",         :default => 0.0
    t.float    "rank",                      :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "seinfeldx_entry_url"
    t.string   "seinfeldscripts_entry_url"
  end

  add_index "episodes", ["director_id"], :name => "index_episodes_on_director_id"
  add_index "episodes", ["rank"], :name => "index_episodes_on_rank"
  add_index "episodes", ["season_id"], :name => "index_episodes_on_season_id"
  add_index "episodes", ["total_votes_share"], :name => "index_episodes_on_total_votes_share"

  create_table "episodes_writers", :id => false, :force => true do |t|
    t.integer  "episode_id"
    t.integer  "writer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seasons", :force => true do |t|
    t.integer  "number"
    t.string   "name"
    t.string   "wikipedia_entry_url"
    t.integer  "episodes_count",      :default => 0
    t.integer  "winning_votes_count", :default => 0
    t.integer  "losing_votes_count",  :default => 0
    t.integer  "total_votes_count",   :default => 0
    t.float    "total_votes_share",   :default => 0.0
    t.float    "rank",                :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seasons", ["rank"], :name => "index_seasons_on_rank"
  add_index "seasons", ["total_votes_share"], :name => "index_seasons_on_total_votes_share"

  create_table "votes", :force => true do |t|
    t.integer  "winner_id"
    t.integer  "loser_id"
    t.datetime "created_at"
  end

  add_index "votes", ["created_at"], :name => "index_votes_on_created_at"
  add_index "votes", ["loser_id"], :name => "index_votes_on_loser_id"
  add_index "votes", ["winner_id"], :name => "index_votes_on_winner_id"

  create_table "writers", :force => true do |t|
    t.string   "name"
    t.integer  "episodes_count",      :default => 0
    t.integer  "winning_votes_count", :default => 0
    t.integer  "losing_votes_count",  :default => 0
    t.integer  "total_votes_count",   :default => 0
    t.float    "total_votes_share",   :default => 0.0
    t.float    "rank",                :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "writers", ["rank"], :name => "index_writers_on_rank"
  add_index "writers", ["total_votes_share"], :name => "index_writers_on_total_votes_share"

end
