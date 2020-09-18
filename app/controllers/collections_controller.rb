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
    if params[:console][:name].empty?
      
      @games = Game.all
      @consoles = Console.all

      collection = Collection.new(params[:collection])
      if collection.save
        
        if !params[:game][:name].empty? 
          # game = add_games_to_collection(collection, params)
          # @errors = ["Game "]
          # @errors[0] += game.errors.full_messages[0]
          # binding.pry
          erb :'collections/new'
        else 
          redirect '/collections'
        end

      else
        @errors = collection.errors.full_messages
        erb :'collections/new'
      end
      
    else
      console = Console.new(name: params[:console][:name])
      @games = Game.all
      @consoles = Console.all
      if console.save
        collection = Collection.create(name: name, console_id: console.id, user_id: current_user.id)
        
        if !params[:game][:name].empty? || params[:collection][:game_ids]
          game = add_games_to_collection(collection, params)
          @errors = ["Game "]
          @errors[0] += game.errors.full_messages[0]
          erb :'collections/new'
        else 
          redirect '/collections'
        end
        
      else 
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

end
