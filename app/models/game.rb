class Game < ActiveRecord::Base
  has_many :cartridges

  validates_presence_of :title
end
