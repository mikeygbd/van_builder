class WishlistPartsController < ApplicationController

  get '/wishlist_parts/new' do
    if logged_in?
      erb :'/wishlist_parts/add_wishlist_part'
    else
      redirect to '/login'
    end
  end

  post '/wishlist_parts/new' do
    if logged_in? && params[:name] != "" && params[:price] != "" && params[:qty] != ""
      @new_wishlist_part = WishlistPart.create(params)
      @wishlist_part_slug = "#{@new_wishlist_part.manufacturer} #{@new_wishlist_part.name} #{@new_wishlist_part.description}".downcase.gsub(' ','+')
      url = "https://www.google.com/search?biw=1680&bih=976&tbm=isch&sa=1&q=" + @wishlist_part_slug + "&oq=" + @wishlist_part_slug + "&gs_l=psy-ab.3..0l10.4067.7152.0.7267.19.19.0.0.0.0.120.1489.17j2.19.0....0...1.1.64.psy-ab..0.19.1488...0i67k1.0.J04MymRcUzg"
      PartsScraper.scrape_part(url)
      @url = PartsScraper.image_url
      @new_wishlist_part.url = @url
      @new_wishlist_part.user_id = current_user.id
      @new_wishlist_part.save
      redirect to '/users/index'
    else
      redirect to '/users/index'
    end
  end

  get '/wishlist_parts' do
    erb :'/wishlist_parts/wishlist_parts'
  end

  get '/wishlist_parts/:id' do
    @wishlist_part = WishlistPart.find(params[:id])
    erb :'/wishlist_parts/individual_wishlist_part'
  end

  get '/wishlist_parts/:id/edit' do
    @wishlist_part = WishlistPart.find(params[:id])
    erb :'/wishlist_parts/edit_wishlist_part'
  end

  patch '/wishlist_parts/:id' do
    @wishlist_part = WishlistPart.find(params[:id])
    if params[:name] != "" &&  params[:price] != "" && params[:qty] != ""
      @wishlist_part.update(:manufacturer => params[:manufacturer], :name => params[:name], :price => params[:price], :qty => params[:qty], :description => params[:description])
    end
    @wishlist_part_slug = "#{@wishlist_part.manufacturer} #{@wishlist_part.name} #{@wishlist_part.description}".downcase.gsub(' ','+')
    url = "https://www.google.com/search?biw=1680&bih=976&tbm=isch&sa=1&q=" + @wishlist_part_slug + "&oq=" + @wishlist_part_slug + "&gs_l=psy-ab.3..0l10.4067.7152.0.7267.19.19.0.0.0.0.120.1489.17j2.19.0....0...1.1.64.psy-ab..0.19.1488...0i67k1.0.J04MymRcUzg"
    PartsScraper.scrape_part(url)
    @url = PartsScraper.image_url
    @wishlist_part.url = @url
    @wishlist_part.user_id = current_user.id
    @wishlist_part.save
    redirect to "/wishlist_parts/#{@wishlist_part.id}"
  end

  get '/wishlist_parts/:id/delete' do
    @wishlist_part = WishlistPart.find(params[:id])
    @wishlist_part.delete
    redirect to "/wishlist_parts"
  end
end
