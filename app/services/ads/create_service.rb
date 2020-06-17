module Ads
  class CreateService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :user_id

    attr_reader :ad

    def call
      @ad = ::Ad.new(@ad.to_h)
      @ad.user_id = @user_id

      coordinates = get_coordinates(@ad.city)
      @ad.lat, @ad.lon = coordinates unless coordinates.nil?

      if @ad.valid?
        @ad.save
      else
        fail!(@ad.errors)
      end
    end

    private

    def get_coordinates(city)
      client = GeocoderService::Client.new
      client.geocode(city)
    end
  end
end
