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
end
