class Collection < ActiveRecord::Base
  belongs_to :user
  belongs_to :console
  has_many :games_collections
  has_many :games, through: :games_collections

  validates :name, :user_id, presence: true
  validates :console_id, presence: {scope: :true, 
    message: "needs to be selected or create a new Console"}
end
