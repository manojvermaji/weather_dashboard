class WeatherController < ApplicationController
  def index
    @location = normalize_location(params[:location] || "New York")
    @weather_data = WeatherService.fetch_weather(@location)
    flash[:alert] = "Weather data unavailable for '#{@location}'." if @weather_data.nil?
  end

  private
  def normalize_location(location)
    location.strip.split.map(&:capitalize).join(' ')
  end  
end
