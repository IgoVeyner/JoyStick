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

    @games = Game.all
    @consoles = Console.all

    if params[:console][:name].empty? # Was the create a new console field left blank? (not creating a new console)
      if !params[:game][:name].empty? # Are you creating a new game?
        game = Game.new(params[:game]) 

        if game.save               # Does the game save? (Unique Name?) 
          collection = Collection.new(params[:collection])

          if collection.save          # Does the collection save?
            collection.games << game
            redirect '/collections'

          else                        # Collection did not save (No console selected)
            @errors = collection.errors.full_messages
            erb :'collections/new'
          end
        else                          # Game did not save (Name was already taken) 
          @errors = ["Game "]
          @errors[0] += game.errors.full_messages[0]
          erb :'collections/new'
        end

      else                          # Not creating a new game (using radio buttons or not adding games yet)
        collection = Collection.new(params[:collection])

        if collection.save          # Does the collection save?
          redirect '/collections'

        else                        # collection did not save, there was no console selected
          @errors = collection.errors.full_messages
          erb :'collections/new'
        end
      end
      
    else                            # Creating a new console
      console = Console.new(name: params[:console][:name])

      if console.save               # Does the console save? (Unique Name?) 
        params[:collection][:console_id] = console.id

        if !params[:game][:name].empty?   # Are you creating a new game?
          game = Game.new(params[:game])

          if game.save                    # Does the game save? (Unique Name?)
            collection = Collection.create(params[:collection])
            collection.games << game
            redirect '/collections'

          else                            # Game did not save (Name was already taken)
            @errors = ["Game "]
            @errors[0] += game.errors.full_messages[0]
            erb :'collections/new'
          end

        else                              # Not creating a new game
          collection = Collection.new(params[:collection])

          if collection.save              # Does the collection save?
            redirect '/collections'

          else                            # Collection did not save
            @errors = collection.errors.full_messages
            erb :'collections/new'
          end
        end

      else                          # Console did not save (Name already taken)
        @errors = ["Console "]
        @errors[0] += console.errors.full_messages[0]
        erb :'collections/new'
      end
    end
  end

  # GET: /collections/5
  get "/collections/:id" do
    redirect_if_not_logged_in
    @collection = Collection.find_by(id: params[:id])
    if @collection 
      erb :"/collections/show"
    else
      @errors = ["#{params[:id]} is not a valid Collection"]
      erb :'failure'
    end
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
