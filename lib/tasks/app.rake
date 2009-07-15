namespace :app do

  namespace :episodes do

    desc "Recalcula o percentual de participação nos votos de todos os episódios."
    task :recalculate => :environment do
      Episode.recalculate_votes_share!
    end

  end

end
