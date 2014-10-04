require 'rails_helper'

RSpec.describe GamesController, :type => :controller do
  fixtures :games
  it "should return list of games for index action" do
    get :index
    expect(json).to have_key('games')
  end
  
  it "should return single game for show action" do
    get :show, id: 1
    expect(json).to have_key('game')
    expect(json['game']['title']).to eq('Test title 1')
  end
  
  it "should get 404 on missing id" do
    get :show, id: 199999999
    expect(response.status).to eq(404)
  end
end
