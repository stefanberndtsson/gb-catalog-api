class GamesController < ApplicationController
  def index(root_name = :games)
    if params[:page] || params[:per_page]
      @games = Game.paginate(page: params[:page], per_page: params[:per_page])
    else
      @games = Game.all
    end
    pagination = {}
    pagination[:records] = @games.count
    pagination[:pages] =  @games.total_pages if @games.respond_to?(:total_pages)
    pagination[:page] = params[:page].to_i if params[:page]
    @games = @games.order(:title)
    render json: {root_name => @games, meta: { pagination: pagination }}
  end

  def game_lists
    index(:game_lists)
  end
  
  def show
    @game = Game.find_by_id(params[:id])
    if @game.nil?
      render json: {}, status: 404
    else
      json_hash = @game.as_json(include: :cartridges)
      json_hash['cartridges'].collect! {|x| x['id']}
      render json: {game: json_hash, cartridges: @game.cartridges}
    end
  end

  def update
    @game = Game.find_by_id(params[:id])
    if @game.nil?
      render json: {}, status: 404
    else
      @game.update_attributes(params_permitted)
      json_hash = @game.as_json(include: :cartridges)
      json_hash['cartridges'].collect! {|x| x['id']}
      render json: {game: json_hash, cartridges: @game.cartridges}
    end
  end
  
  private
  def params_permitted
    params.require(:game).permit(:title, :note)
  end
end
