class Console < ActiveRecord::Base
  has_many :collections
  has_many :games, through: :collections
  has_many :users, through: :collections
end
