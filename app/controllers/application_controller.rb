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

end
