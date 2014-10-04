class CartridgesController < ApplicationController
  def index
    @cartridges = Game.find_by_id(params[:game_id]).try(:cartridges)
    if @cartridges.nil?
      render json: {}, status: 404
    else
      render json: {cartridges: @cartridges}
    end
  end
  
  def show
    game = Game.find_by_id(params[:game_id])
    @cartridge = game.try(:cartridges).try(:find_by_id, params[:id])
    if @cartridge.nil?
      render json: {}, status: 404
    else
      render json: @cartridge.to_json(root: true)
    end
  end
end
