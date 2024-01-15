class MapquestService
  def self.get_location(location)
    response = conn.get("address?key=#{Rails.application.credentials.mapquest[:key]}&location=#{location}")
    parse = JSON.parse(response.body, symbolize_names: true)
    parse[:results].first[:locations].first[:latLng]
    # require 'pry';binding.pry
  end

  #don't know if this will work with this API, but keeping for now just in case
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolie_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://www.mapquestapi.com/geocoding/v1/')
  end
end