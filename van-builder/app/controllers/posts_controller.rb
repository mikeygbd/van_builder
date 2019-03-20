class PostsController < ApplicationController

  get '/posts/new' do
    if logged_in?
      erb :'/posts/add_post'
    else
      redirect to '/login'
    end
  end

  post '/posts/new' do
    if logged_in? && params[:title] != "" && params[:description] != ""
      @new_post = Post.create(params)
      # @new_post.video_link = url
      # VideoScraper.scrape_video(url)
      # @url = VideoScraper.image_url
      # @new_post.url = @url
      @new_post.user_id = current_user.id
      @new_post.save
      redirect to '/posts'
    else
      redirect to '/users/index'
    end
  end

  get '/posts' do
    erb :'/posts/posts'
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :'/posts/individual_post'
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :'/posts/edit_post'
  end

  patch '/posts/:id' do
    @post = Post.find(params[:id])
    if params[:title] != "" &&  params[:description] != ""
      @post.update(:title => params[:title], :description => params[:description])
    end
    # @post.video_link = url
    # VideoScraper.scrape_video(url)
    # @url = VideoScraper.image_url
    # @post.url = @url
    @post.user_id = current_user.id
    @post.save
    redirect to "/posts/#{@post.id}"
  end

  get '/posts/:id/delete' do
    @post = Post.find(params[:id])
    @post.delete
    redirect to "/posts"
  end
end
