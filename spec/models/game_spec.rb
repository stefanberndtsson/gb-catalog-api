require 'rails_helper'

RSpec.describe Game, :type => :model do
  it "should save a complete item" do
    game = Game.new(title: "Test title", note: "Test note")
    expect(game.save).to be_truthy
  end
  
  it "should require title" do
    game = Game.new(note: "Test note")
    expect(game.save).to be_falsey
  end
  
  it "should reference all its cartridges" do
    game = Game.create(title: "Test title", note: "Test note")
    expect(game.cartridges).to respond_to(:each)
    game.cartridges.create(casing: "Clear", code: "CGB-XXXX-EUR")
    game.cartridges.create(casing: "Clear", code: "CGB-XXXX-EUR")
    expect(game.cartridges.count).to be(2)
  end
end
