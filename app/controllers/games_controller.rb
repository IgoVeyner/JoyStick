class GamesController < ApplicationController

  get "/games" do
    erb :"/games/index"
  end

  get "/games/new" do
    erb :"/games/new"
  end

  post "/games" do
    redirect "/games"
  end

  get "/games/:slug" do
    erb :"/games/show"
  end

  get "/games/:slug/edit" do
    erb :"/games/edit"
  end

  patch "/games/:slug" do
    redirect "/games/:slug"
  end

  delete "/games/:slug" do
    redirect "/games"
  end
end
