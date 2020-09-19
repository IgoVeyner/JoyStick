class GamesController < ApplicationController

  get "/games" do
    redirect_if_not_logged_in
    erb :"/games/index"
  end

  get "/games/new" do
    redirect_if_not_logged_in
    erb :"/games/new"
  end

  post "/games" do
    redirect "/games"
  end

  get "/games/:slug" do
    redirect_if_not_logged_in
    erb :"/games/show"
  end

  get "/games/:slug/edit" do
    redirect_if_not_logged_in
    erb :"/games/edit"
  end

  patch "/games/:slug" do
    redirect "/games/:slug"
  end

  delete "/games/:slug" do
    redirect "/games"
  end
end
