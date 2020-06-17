require 'dry/initializer'
require_relative 'api'

module GeocoderService
  class Client
    extend Dry::Initializer[undefined: false]
    include Api

    option :url, default: -> { 'http://localhost:3003/v1' }
    option :connection, default: -> { build_connection }

    private

    def build_connection
      Faraday.new(@url) do |connection|
        connection.request :json
        connection.response :json, content_type: /\bjson$/
        connection.adapter Faraday.default_adapter
      end
    end
  end
end
