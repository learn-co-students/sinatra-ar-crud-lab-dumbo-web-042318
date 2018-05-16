
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :root
  end

  ###CREATE###
  get '/posts/new' do
    
    erb :new
  end

  post '/posts' do
    # binding.pry
    @post = Post.create(params[:post])

    redirect "/posts"
  end

  ###READ###
  get '/posts' do
    @posts = Post.all 

    erb :index
  end

  get '/posts/:id' do
    # binding.pry
    @post = Post.find(params["id"])
    
    erb :show
  end

  ###UPDATE###
  get '/posts/:id/edit' do
    @post = Post.find(params["id"])

    erb :edit 
  end

  patch '/posts/:id' do
    @post = Post.find(params["id"])
    @post.update(params[:post])
   
    redirect "/posts/#{@post.id}"
  end 

  ##DELETE###
  delete '/posts/:id/delete' do
    @post = Post.find(params[:id])
    @post.destroy

    redirect '/posts'
  end
end
