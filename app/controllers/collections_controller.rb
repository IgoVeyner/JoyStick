class CollectionsController < ApplicationController

  # GET: /collections
  get "/collections" do
    redirect_if_not_logged_in
    @collections = Collection.all
    erb :"/collections/index"
  end

  # GET: /collections/new
  get "/collections/new" do
    @consoles = Console.all
    @games = Game.all
    redirect_if_not_logged_in
    erb :"/collections/new"
  end

  # POST: /collections
  post "/collections" do
    
    name = params[:collection][:name]
    if params[:console][:name].empty?
      
      console_id = params[:collection][:console_id][0].to_i if params[:collection][:console_id]
      collection = Collection.new(name: name, console_id: console_id, user_id: current_user.id)
      if collection.save
        
        game = add_games_to_collection(collection, params)
        
        if game == nil
          redirect '/collections'
        end

        @games = Game.all
        @consoles = Console.all
        @errors = ["Game "]
        @errors[0] += game.errors.full_messages[0]
        erb :'collections/new'
        # if !@errors
        #   redirect "/collections"
        # else 
        #   erb :'collections/new'
        # end
      else
        @consoles = Console.all
        @errors = collection.errors.full_messages
        erb :'collections/new'
      end
      
    else
      console = Console.new(name: params[:console][:name])
      if console.save
        collection = Collection.create(name: name, console_id: console.id, user_id: current_user.id)
        redirect "/collections"
      else 
        @games = Game.all
        @consoles = Console.all
        @errors = ["Console "]
        @errors[0] += console.errors.full_messages[0]
        erb :'collections/new'
      end
    end
  end

  # GET: /collections/5
  get "/collections/:id" do
    redirect_if_not_logged_in
    erb :"/collections/show.html"
  end

  # GET: /collections/5/edit
  get "/collections/:id/edit" do
    redirect_if_not_logged_in
    erb :"/collections/edit.html"
  end

  # PATCH: /collections/5
  patch "/collections/:slug" do
    redirect "/collections/:id"
  end

  # DELETE: /collections/5/delete
  delete "/collections/:id/delete" do
    redirect "/collections"
  end

  def add_games_to_collection(collection, params)
    if !params[:game][:name].empty?
      game = Game.new(name: params[:game][:name])
      if game.save
        collection.games << game
        redirect "/collections"
      else
        game
        # @games = Game.all
        # @consoles = Console.all
        # @errors = ["Game "]
        # @errors[0] += game.errors.full_messages[0]
        # erb :'collections/new'
      end
    
    elsif params[:collection][:game_ids]
      params[:collection][:game_ids].each do |game_id|
        collection.games << Game.find_by(id: game_id.to_i)
      end
      redirect "/collections"
    end
  end
end
