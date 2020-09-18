require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "JoyStick 1234sdafASDjklaFDS42LMfj asajj432dsjk37qwFsF234adhZf"
  end

  get "/" do
    erb :welcome
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def redirect_if_not_logged_in
      redirect '/login' if !logged_in?
    end

    def redirect_if_logged_in
      redirect "/users/#{current_user.slug}" if logged_in?
    end
      
    def add_games_to_collection(collection, params)
      if !params[:game][:name].empty?
        game = Game.new(name: params[:game][:name])
        if game.save
          collection.games << game
          redirect "/collections"
        else
          game
        end
      
      elsif params[:collection][:game_ids]
        params[:collection][:game_ids].each do |game_id|
          collection.games << Game.find_by(id: game_id.to_i)
        end
        redirect "/collections"
      end
    end

  end

end
