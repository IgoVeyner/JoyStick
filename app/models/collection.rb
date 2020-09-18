class Collection < ActiveRecord::Base
  belongs_to :user
  belongs_to :console
  has_many :games_collections
  has_many :games, through: :games_collections

  validates :name, :console_id, :user_id, presence: true
end
