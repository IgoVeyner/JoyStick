class CollectionsController < ApplicationController

  # GET: /collections
  get "/collections" do
    erb :"/collections/index.html"
  end

  # GET: /collections/new
  get "/collections/new" do
    erb :"/collections/new.html"
  end

  # POST: /collections
  post "/collections" do
    redirect "/collections"
  end

  # GET: /collections/5
  get "/collections/:id" do
    erb :"/collections/show.html"
  end

  # GET: /collections/5/edit
  get "/collections/:id/edit" do
    erb :"/collections/edit.html"
  end

  # PATCH: /collections/5
  patch "/collections/:slug" do
    redirect "/collections/:id"
  end

  # DELETE: /collections/5/delete
  delete "/collections/:id/delete" do
    redirect "/collections"
  end
end
