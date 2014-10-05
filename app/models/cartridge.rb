class Cartridge < ActiveRecord::Base
  belongs_to :game

  validates_presence_of :game_id
  validates_presence_of :casing
  validates_inclusion_of :casing, in: ["Black", "Grey", "Clear", "None"]
  validates_format_of :code, with: /\A(DMG|CGB)-([A-Z0-9]){2,4}-([A-Z]{3})/, allow_blank: true
end
