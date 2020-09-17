class Game < ActiveRecord::Base
  has_many :games_collections
  has_many :collections, through: :games_collections
  has_many :consoles, through: :collections
  has_many :users, through: :collections
end
