class CountriesController < ApplicationController
  
  def index
    @countries = Country.all  
  end
  
  def countries_from_api
      @countries = Country.get_countries_data
      #raise @countries.inspect
  end
  
end
