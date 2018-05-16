require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @posts = Post.all
    erb :index   
  end

  get '/posts/new' do 
    erb :new
  end 

  post '/posts' do
    Post.create(params)
    @posts = Post.all
    erb :index
  end 
# Create the get '/posts/:id' controller action. 
  # This action should use Active Record to grab the post with the id that is in the params and set it equal to @post. 
  # Then, it should render the show.erb view page. That view should use erb to render the @post's title and content.
  get '/posts' do
    @posts = Post.all
    erb :index 
  end 

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end 
# The Update CRUD action corresponds to the edit controller action and view.

# Create a controller action, get '/posts/:id/edit', that renders the view, edit.erb.i
  # This view should contain a form to update a specific blog post and POSTs to a controller action, patch '/posts/:id'.

  get '/posts/:id/edit' do 
    @post = Post.find(params[:id])
    erb :edit
  end 

  patch '/post/:id' do
    double = params.dup
    double.delete(:_method)
    Post.update(params_copy)
    @post = Post.find(params[:id])
    redirect "/posts/#{@post.id}"
  end

  def params_copy
    params_copy = params.dup
    params_copy.delete "id"
    params_copy.delete "_method"
    params_copy
  end


  delete '/posts/:id' do
    # do something on the database
    post = Post.find(params["id"])
    post.destroy

    # redirect somewhere
    erb :delete 
  end
end
