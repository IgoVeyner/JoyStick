class ConsolesController < ApplicationController

  get "/consoles" do
    erb :"/consoles/index"
  end

  get "/consoles/new" do
    erb :"/consoles/new"
  end

  post "/consoles" do
    redirect "/consoles"
  end

  get "/consoles/:id" do
    erb :"/consoles/show"
  end

  get "/consoles/:id/edit" do
    erb :"/consoles/edit"
  end

  patch "/consoles/:id" do
    redirect "/consoles/:id"
  end

  delete "/consoles/:id" do
    redirect "/consoles"
  end
end
