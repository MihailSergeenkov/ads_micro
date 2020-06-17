module GeocoderService
  module Api
    def geocode(city)
      response = connection.get('geocoder', city: city)
      response.body if response.success?
    end
  end
end
