require 'rails_helper'

RSpec.describe CartridgesController, :type => :controller do
  fixtures :cartridges
  it "should list all cartridges for a game" do
    get :index, game_id: 1
    expect(json).to have_key('cartridges')
  end
  
  it "should return 404 when listing cartridges for a non-existing game id" do
    get :index, game_id: 1999999999
    expect(response.status).to be(404)
  end
  
  it "should return a single cartridge for show action" do
    get :show, id: 1, game_id: 1
    expect(json).to have_key('cartridge')
  end

  it "should return 404 for a non-existing cartridge" do
    get :show, id: 1999999999, game_id: 1
    expect(response.status).to be(404)
  end

  it "should return 404 for cartridge not belonging to provided game id" do
    get :show, id: 3, game_id: 1
    expect(response.status).to be(404)
  end

  it "should return 404 when requesting cartridge of a non-existing game id" do
    get :show, id: 3, game_id: 1999999999
    expect(response.status).to be(404)
  end
end
