class PlacesController < ApplicationController

  def index
  end

  def show
    places = BeermappingApi.places_in(session[:city])
    @place = places[places.index{|x| x.id == "#{params[:id]}"}]
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    session[:city] = params[:city]
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
end