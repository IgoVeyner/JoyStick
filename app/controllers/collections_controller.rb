class CollectionsController < ApplicationController

  get "/collections" do
    redirect_if_not_logged_in
    @collections = Collection.all
    erb :"/collections/index"
  end

  get "/collections/new" do
    redirect_if_not_logged_in
    @consoles = Console.all
    @games = Game.all
    erb :"/collections/new"
  end

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

  get "/collections/:id/edit" do
    redirect_if_not_logged_in
    @collection = Collection.find_by(id: params[:id])

    if current_user == @collection.user
      @consoles = Console.all
      @games = Game.all
      erb :"/collections/edit"
    else
      redirect "/collections/#{@collection.id}"
    end
  end

  patch "/collections/:id" do
    @collection = Collection.find_by(params[:id])

    if !params[:collection].keys.include?(:game_ids)
      params[:collection][:game_ids] = []
    end

    @collection.update(params[:collection])
    
    if !params[:game][:name].empty?     # If making a new game
      
      game = Game.new(params[:game])
      if game.save                      # Does the game save? (Unique Name)
        @collection.games << game
        redirect "/collections/#{@collection.id}"
      else                              # Did not save (Name already taken)
        @consoles = Console.all
        @games = Game.all
        @errors = ["Game "]
        @errors[0] += game.errors.full_messages[0]
        erb :'collections/edit'
      end
    else                                # Not making a new game
      redirect "/collections/#{@collection.id}"
    end
  end

  delete "/collections/:id" do
    collection = Collection.find_by(params[:id])
    collection.destroy
    redirect "/collections"
  end

end
