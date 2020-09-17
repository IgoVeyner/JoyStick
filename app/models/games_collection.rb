class GamesCollection < ActiveRecord::Base
  belongs_to :game
  belongs_to :collection
end
