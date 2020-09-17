class User < ActiveRecord::Base
  has_many :collections
  has_many :consoles, through: :collections
  has_many :games, through: :collections
end
