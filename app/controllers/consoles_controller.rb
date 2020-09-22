class ConsolesController < ApplicationController

  get "/consoles" do
    redirect_if_not_logged_in
    @consoles = Console.all.sort_by(&:name)
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

  get "/consoles/:slug/edit" do
    redirect_if_not_logged_in
    @console = Console.find_by_slug(params[:slug])

    if @console
      erb :"/consoles/edit"
    else
      @errors = ["#{params[:slug]} is not a valid Console"]
      erb :'failure'
    end
  end

  patch "/consoles/:slug" do
    console = Console.find_by_slug(params[:slug])
    console.update(params[:console])
    redirect "/consoles/#{console.slug}"
  end

  delete "/consoles/:slug" do
    console = Console.find_by_slug(params[:slug])
    console.destroy
    redirect "/consoles"
  end
end
