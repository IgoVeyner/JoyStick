class Console < ActiveRecord::Base
  has_many :collections
  has_many :games, through: :collections
  has_many :users, through: :collections

  validates :name, presence: true
  validates :name, uniqueness: true

  def slug 
    self.name.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find {|u| u.slug == slug}
  end
end
