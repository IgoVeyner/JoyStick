class ConsolesController < ApplicationController

  get "/consoles" do
    redirect_if_not_logged_in
    @consoles = Console.all
    erb :"/consoles/index"
  end
  
  get "/consoles/new" do
    redirect_if_not_logged_in
    erb :"/consoles/new"
  end

  post "/consoles" do
    console = Console.new(params[:console])
    if console.save
      redirect "/consoles"
    else
      @errors = console.errors.full_messages
      erb :'consoles/new'
    end 
  end

  get "/consoles/:slug" do
    redirect_if_not_logged_in
    @console = Console.find_by_slug(params[:slug])
    if @console
      erb :"/consoles/show"
    else
      @errors = ["#{params[:slug]} is not a valid Console"]
      erb :'failure'
    end
  end

  get "/consoles/:id/edit" do
    redirect_if_not_logged_in
    erb :"/consoles/edit"
  end

  patch "/consoles/:id" do
    redirect "/consoles/:id"
  end

  delete "/consoles/:id" do
    redirect "/consoles"
  end
end
