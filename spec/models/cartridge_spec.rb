require 'rails_helper'

RSpec.describe Cartridge, :type => :model do
  before(:each) do
    @game = Game.create(title: "Test game")
  end
  it "should save a complete item" do
    cart = Cartridge.new(game_id: @game.id, casing: "Clear", code: "CGB-XXXX-EUR", note: "Test Cartridge Note")
    expect(cart.save).to be_truthy
  end
  
  it "should have a game reference" do
    cart = Cartridge.new(casing: "Clear", code: "CGB-XXXX-EUR", note: "Test Cartridge Note")
    expect(cart.save).to be_falsey
  end
  
  it "should require casing" do
    cart = Cartridge.new(game_id: @game.id, code: "CGB-XXXX-EUR", note: "Test Cartridge Note")
    expect(cart.save).to be_falsey
  end

  it "should have a casing from a given list" do
    cart = Cartridge.new(game_id: @game.id, casing: "Clear", code: "CGB-XXXX-EUR", note: "Test Cartridge Note")
    expect(cart.save).to be_truthy
    cart = Cartridge.new(game_id: @game.id, casing: "Black", code: "CGB-XXXX-EUR", note: "Test Cartridge Note")
    expect(cart.save).to be_truthy
    cart = Cartridge.new(game_id: @game.id, casing: "Unknown", code: "CGB-XXXX-EUR", note: "Test Cartridge Note")
    expect(cart.save).to be_falsey
  end
  
  it "should have a properly formatted code if present" do
    cart = Cartridge.new(game_id: @game.id, casing: "Clear", note: "Test Cartridge Note")
    expect(cart.save).to be_truthy
    cart = Cartridge.new(game_id: @game.id, casing: "Clear", code: "Blaha", note: "Test Cartridge Note")
    expect(cart.save).to be_falsey
  end
  
  it "should be referenced to its parent game" do
    cart = Cartridge.new(game_id: @game.id, casing: "Clear", code: "CGB-XXXX-EUR", note: "Test Cartridge Note")
    expect(cart.save).to be_truthy
    expect(cart.game).to be_truthy
  end
end
