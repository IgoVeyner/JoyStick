class Game < ActiveRecord::Base
  has_many :games_collections, dependent: :destroy
  has_many :collections, through: :games_collections
  has_many :consoles, through: :collections
  has_many :users, through: :collections
  
  validates :name, presence: true
  validates :name, uniqueness: true

  def slug 
    self.name.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find {|game| game.slug == slug}
  end
end
