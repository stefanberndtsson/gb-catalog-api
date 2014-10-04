class GamesController < ApplicationController
  def index
    @games = Game.all
    render json: {games: @games}
  end
  
  def show
    @game = Game.find_by_id(params[:id])
    if @game.nil?
      render json: {}, status: 404
    else
      render json: @game.to_json(root: true)
    end
  end
end
