class GamesController < ApplicationController

  get "/games" do
    redirect_if_not_logged_in
    @games = Game.all.sort_by(&:name)
    erb :"/games/index"
  end

  get "/games/new" do
    redirect_if_not_logged_in
    erb :"/games/new"
  end

  post "/games" do
    game = Game.new(params[:game])

    if game.save
      redirect "/games"
    else
      @errors = game.errors.full_messages
      erb :'games/new'
    end
  end

  get "/games/:slug" do
    redirect_if_not_logged_in
    @game = Game.find_by_slug(params[:slug])
    
    if @game
      erb :"/games/show"
    else
      @errors = ["#{params[:slug]} is not a valid game"]
      erb :'failure'
    end
  end

  get "/games/:slug/edit" do
    redirect_if_not_logged_in
    @game = Game.find_by_slug(params[:slug])

    if @game
      erb :"/games/edit"
    else
      @errors = ["#{params[:slug]} is not a valid game"]
      erb :'failure'
    end
  end

  patch "/games/:slug" do
    @game = Game.find_by_slug(params[:slug])

    if @game.update(params[:game])
      redirect "/games/#{@game.slug}"
    else
      @errors = @game.errors.full_messages
      erb :'games/edit'
    end
  end

  delete "/games/:slug" do
    game = Game.find_by_slug(params[:slug])
    game.destroy
    redirect "/games"
  end
end
