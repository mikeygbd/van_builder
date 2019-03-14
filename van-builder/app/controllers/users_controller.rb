class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/parts'
    else
      erb :'/users/sign_up'
    end
  end

  get '/users/index' do
    PartsScraper.scrape_renogy
    if logged_in?
      @all_parts = Part.all
      erb :'/users/index'
    else
      redirect to '/login'
    end
  end

  post '/signup' do
    if params[:name] != "" && params[:username] != "" && params[:password] != ""
     @new_user = User.new(:name => params[:name], :username => params[:username], :password => params[:password], :van_make => params[:van_make], :van_model => params[:van_model], :van_year => params[:van_year], :van_wheelbase => params[:van_wheelbase], :van_color => params[:van_color])
     @van_slug = "#{@new_user.van_make} #{@new_user.van_model} #{@new_user.van_year} #{@new_user.van_wheelbase} #{@new_user.van_color}".downcase.gsub(' ','+')
     url = "https://www.google.com/search?biw=1680&bih=976&tbm=isch&sa=1&q=" + @van_slug + "&oq=" + @van_slug + "&gs_l=psy-ab.3..0l10.4067.7152.0.7267.19.19.0.0.0.0.120.1489.17j2.19.0....0...1.1.64.psy-ab..0.19.1488...0i67k1.0.J04MymRcUzg"
     VanScraper.scrape_van(url)
     @url = VanScraper.image_url
     @new_user.url = @url
     @new_user.save
     session[:user_id] = @new_user.id
     redirect to '/users/index'
    else
     redirect to '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/users/index'
    else
      erb :'/users/log_in'
    end
  end

  post '/login' do
    @current_user = User.find_by(:username => params[:username])

    if @current_user && @current_user.authenticate(params[:password])
      session[:user_id] = @current_user.id
      redirect to '/users/index'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session[:user_id] = nil
      redirect to '/'
    else
      redirect to '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/#{@user.slug}"
  end

  get '/users/:id/delete' do
    if logged_in?
    @user = current_user
    @user.delete
    session[:user_id] = nil
    redirect to '/'
  else
    redirect to '/'
    end
  end

end
