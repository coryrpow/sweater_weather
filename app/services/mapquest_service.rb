class MapquestService

  def self.get_trip(origin, destination)
    response = conn_v2.get("route?key=#{Rails.application.credentials.mapquest[:key]}&from=#{origin}&to=#{destination}")
    parse = JSON.parse(response.body, symbolize_names: true)
    if parse[:route][:routeError]
      impossible(parse)
    else
      two_times(parse)
    end
  end

  def self.two_times(parse)
    {
      time: parse[:route][:time],
      formatted_time: parse[:route][:formattedTime]  
    }
  end

  def self.impossible(parse)
    {
      impossible: "This road trip is not possible. Consider consulting a map.",  
      status: 428
    }
  end

  def self.get_location(location)
    response = conn.get("address?key=#{Rails.application.credentials.mapquest[:key]}&location=#{location}")
    parse = JSON.parse(response.body, symbolize_names: true)
    parse[:results].first[:locations].first[:latLng]
  end

  def self.conn_v2
    Faraday.new(url: 'https://www.mapquestapi.com/directions/v2/')
  end

  def self.conn
    Faraday.new(url: 'https://www.mapquestapi.com/geocoding/v1/')
  end
end