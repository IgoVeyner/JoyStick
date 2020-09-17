class User < ActiveRecord::Base
  has_secure_password
  validates :username, :password, presence: true
  validates :username, uniqueness: true
  
  has_many :collections
  has_many :consoles, through: :collections
  has_many :games, through: :collections

  def slug 
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find {|u| u.slug == slug}
  end
end
