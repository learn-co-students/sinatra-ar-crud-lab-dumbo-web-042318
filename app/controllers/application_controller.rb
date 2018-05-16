
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    
  end

  ##create form
  get '/posts/new' do
    erb :new
  end 

  ##create instance
  post '/posts' do
    @post = Post.create(params)
    redirect '/posts'
  end 

  ##show all
  get '/posts' do
    @posts = Post.all
    erb :index
  end 

  get '/delete' do
    erb :delete
  end 

  ##show individual
  get '/posts/:id' do
    @post = Post.find(params["id"])
    erb :show
  end 

  get '/posts/:id/edit' do
    @post = Post.find(params["id"])
    erb :edit
  end

  patch '/posts/:id' do
    @post = Post.find(params["id"])
    @post.update(new_post_params)
    redirect "/posts/#{@post.id}"
  end

  delete '/posts/:id/delete' do
    @post = Post.find(params["id"])
    @post.destroy

    redirect '/delete'
  end 

  private

  def new_post_params
    new_post_copy = params.dup
    new_post_copy.delete "id"
    new_post_copy.delete "_method"
    new_post_copy
  end 

end
