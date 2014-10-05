require 'rails_helper'

RSpec.describe GamesController, :type => :controller do
  fixtures :games
  fixtures :cartridges

  describe "get list" do
    it "should return list of all games for index action" do
      Game.per_page = 2
      get :index
      expect(json).to have_key('games')
      expect(json['games'].count).to be(3)
      expect(json).to have_key('meta')
      expect(json['meta']['pagination']['records']).to be(3)
    end
  
    it "should return paginated lists when per_page or page specified" do
      get :index, per_page: 2, page: 1
      expect(json['games'].count).to be(2)
      expect(json['meta']['pagination']['records']).to be(3)
      expect(json['meta']['pagination']['pages']).to be(2)
      expect(json['meta']['pagination']['page']).to be(1)
    end

    it "should include only cartridges belonging to games on requested page" do
      get :index, per_page: 2, page: 1
      expect(json['games'].count).to be(2)
      expect(json['cartridges']).to be_kind_of(Array)
      expect(json['cartridges'].count).to be(4)
    end

    it "should include cartridge ids on game objects when fetching lists" do
      get :index
      expect(json['games'][0]['cartridges']).to be_kind_of(Array)
      expect(json['games'][0]['cartridges'].count).to be(2)
    end
  
    it "should include cartridge list when fetching lists" do
      get :index
      expect(json['cartridges']).to be_kind_of(Array)
      expect(json['cartridges'].count).to be(Cartridge.count)
    end
    
    it "should return list ordered by title" do
      get :index
      expect(json['games'].first['title']).to eq('Test title 1')
    end
  end

  describe "update single game" do
    it "should write provided fields" do
      put :update, id: 1, game: { note: "New note" }
      expect(Game.find(1).note).to eq("New note")
    end
    
    it "should fail on non-existing game" do
      put :update, id: 199999999, game: { note: "New note" }
      expect(response.status).to eq(404)
    end

    it "should return the updated game when successful" do
      put :update, id: 1, game: { note: "New note" }
      expect(json['game']['note']).to eq("New note")
    end
  end
  
  describe "get single game" do
    it "should return single game for show action" do
      get :show, id: 1
      expect(json).to have_key('game')
      expect(json['game']['title']).to eq('Test title 3')
    end
    
    it "should get 404 on missing id" do
      get :show, id: 199999999
      expect(response.status).to eq(404)
    end
    
    it "should include cartridge list when fetching single item" do
      get :show, id: 1
      expect(json['cartridges']).to be_kind_of(Array)
      expect(json['cartridges'].count).to be(1)
    end
  end
end
