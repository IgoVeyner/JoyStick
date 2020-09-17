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
    redirect_if_logged_in
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:user][:username])
    
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect "/user/#{user.slug}"
    else 
      redirect '/login'
    end
  end

  delete '/logout' do
    # remember to add a form on the nav bar to log the current user out
    session[user_id] = nil
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end
end
