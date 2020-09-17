class UsersController < ApplicationController

  get '/signup' do
    redirect_if_logged_in
    erb :'users/signup'
  end
  
  post '/signup' do
    user = User.new(params[:user])
    
    if user.save 
      session[:user_id] = user.id
      redirect "/user/#{user.slug}"
    else
      redirect '/signup'
    end
  end

  get '/login' do
  end

  post '/login' do
  end

  get '/users/:slug' do
  end
end
