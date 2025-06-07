class WeatherService
  include HTTParty
  base_uri 'https://api.openweathermap.org/data/2.5'

  def self.fetch_weather(location)
    result = Geocoder.search(location).first
		Rails.logger.info "Geocoder Result: #{result.inspect}"
    return nil unless result 

    coordinates = result.coordinates
    response = get("/weather", {
      query: {
        lat: coordinates[0],
        lon: coordinates[1],
        units: "metric",
        appid: ENV['OPEN_WEATHER_API_KEY']

      }
    })
    handle_response(response)
  end

  private

  def self.handle_response(response)
    if response.success?
      response.parsed_response
    else
      Rails.logger.error "Weather API Error: #{response.code} - #{response.body}"
      nil
    end
  end
end
