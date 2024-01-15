class YelpService

  def self.get_restaurant(food_type, lat, lon)
    response = conn.get("businesses/search?term=#{food_type}&latitude=#{lat}&longitude=#{lon}")
    parse = JSON.parse(response.body, symbolie_names: true)
    require 'pry';binding.pry

  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolie_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.yelp.com/v3/') do |faraday|
      faraday.headers["Authorization"] = "Bearer #{Rails.application.credentials.yelp[:key]}"
    end
  end
end