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
    if params[:game_id]
      game = Game.find_by_id(params[:game_id])
      @cartridge = game.try(:cartridges).try(:find_by_id, params[:id])
    else
      @cartridge = Cartridge.find_by_id(params[:id])
    end
    if @cartridge.nil?
      render json: {}, status: 404
    else
      render json: @cartridge.to_json(root: true)
    end
  end
end
