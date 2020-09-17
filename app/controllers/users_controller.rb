class UsersController < ApplicationController

  get '/signup' do
    redirect_if_logged_in
    erb :'users/signup'
  end
  
  post '/signup' do
  end

  get '/login' do
  end

  post '/login' do
  end

  get '/users/:slug' do
  end
end
