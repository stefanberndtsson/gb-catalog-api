class Game < ActiveRecord::Base
  self.per_page = 15
  has_many :cartridges

  validates_presence_of :title

  def as_json(options = {})
    super.merge({
                  cartridges: cartridge_ids
                })
  end
end
