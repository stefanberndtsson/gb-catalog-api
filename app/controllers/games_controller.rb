class GamesController < ApplicationController
  def index
    @games = Game.all
    render json: {games: @games}
  end
  
  def show
    @game = Game.find_by_id(params[:id])
    if @game
      render json: @game.to_json(root: true)
    else
      render json: {}, status: 404
    end
  end
end
