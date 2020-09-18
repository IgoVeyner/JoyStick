class Console < ActiveRecord::Base
  has_many :collections
  has_many :games, through: :collections
  has_many :users, through: :collections

  def slug 
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find {|u| u.slug == slug}
  end
end
