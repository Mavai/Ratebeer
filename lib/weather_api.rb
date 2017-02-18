class WeatherApi

  def self.weather_in(city)
    city = city.downcase
    Rails.cache.fetch("#{city}_weather", expires_in: 1.weeks) {fetch_weather_in(city)}
  end

  def self.fetch_weather_in(city)
    url = "https://api.apixu.com/v1/current.json?key=02752fb9884d44859c8160429171802&q="
    weather_info = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    return[] if weather_info['error']
    Weather.new(weather_info)
  end
end