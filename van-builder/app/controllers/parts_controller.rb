require 'pry'
class PartsController < ApplicationController

  get '/parts/new' do
    if logged_in?
      erb :'/parts/add_part'
    else
      redirect to '/login'
    end
  end

  post '/parts/new' do
    if logged_in? && params[:manufacturer] != "" && params[:name] != "" && params[:price] != "" && params[:qty] != ""
      @new_part = Part.create(params)
      @part_slug = "#{@new_part.manufacturer} #{@new_part.name} #{@new_part.description}".downcase.gsub(' ','+')
      url = "https://www.google.com/search?biw=1680&bih=976&tbm=isch&sa=1&q=" + @part_slug + "&oq=" + @part_slug + "&gs_l=psy-ab.3..0l10.4067.7152.0.7267.19.19.0.0.0.0.120.1489.17j2.19.0....0...1.1.64.psy-ab..0.19.1488...0i67k1.0.J04MymRcUzg"
      PartsScraper.scrape_part(url)
      @url = PartsScraper.image_url
      @new_part.url = @url
      @new_part.user_id = current_user.id
      @new_part.save
      redirect to '/parts'
    else
      redirect to '/users/index'
    end
  end

  get '/parts' do
    erb :'/parts/parts'
  end

  get '/parts/:id' do
    @part = Part.find(params[:id])
    erb :'/parts/individual_part'
  end

  get '/parts/:id/edit' do
    @part = Part.find(params[:id])
    erb :'/parts/edit_part'
  end

  patch '/parts/:id' do
    @part = Part.find(params[:id])
    if params[:manufacturer] != "" && params[:name] != "" &&  params[:price] != "" && params[:qty] != ""
      @part.update(:manufacturer => params[:manufacturer], :name => params[:name], :price => params[:price], :qty => params[:qty], :description => params[:description])
    end
    @part_slug = "#{@part.manufacturer} #{@part.name} #{@part.description}".downcase.gsub(' ','+')
    url = "https://www.google.com/search?biw=1680&bih=976&tbm=isch&sa=1&q=" + @part_slug + "&oq=" + @part_slug + "&gs_l=psy-ab.3..0l10.4067.7152.0.7267.19.19.0.0.0.0.120.1489.17j2.19.0....0...1.1.64.psy-ab..0.19.1488...0i67k1.0.J04MymRcUzg"
    PartsScraper.scrape_part(url)
    @url = PartsScraper.image_url
    @part.url = @url
    @part.user_id = current_user.id
    @part.save
    redirect to "/parts/#{@part.id}"
  end

  get '/parts/:id/delete' do
    @part = Part.find(params[:id])
    @part.delete
    redirect to "/parts"
  end
end
