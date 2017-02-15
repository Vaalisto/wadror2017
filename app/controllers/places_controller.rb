class PlacesController < ApplicationController
  def index
  end

  def show
    cached_places = Rails.cache.read(session[:last_city])
    @place = cached_places.find{ |p| p.id == params[:id]}
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:last_city] = params[:city]
      render :index
    end
  end
end