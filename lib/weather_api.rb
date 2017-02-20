class WeatherApi

  def self.weather_in(city)
    city = city.downcase
    Rails.cache.fetch("#{city}_weather", expires_in: 1.weeks) {fetch_weather_in(city)}
  end

  def self.fetch_weather_in(city)
    url = "https://api.apixu.com/v1/current.json?key=#{key}="
    weather_info = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    return nil if weather_info['error']
    Weather.new(weather_info)
  end

  def self.key
    raise 'WEATHERAPI env variable not defined' if ENV['WEATHERAPI'].nil?
    ENV['WEATHERAPI']
  end
end