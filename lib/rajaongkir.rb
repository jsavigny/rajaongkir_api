require 'rajaongkir/api'
require 'rajaongkir/error'
require 'rajaongkir/version'

module Rajaongkir
  class << self
    def new(api_key, opts = {})
      Rajaongkir::API.new(api_key, default_options.merge(opts))
    end

    private

    def default_options
      {
        host: 'https://api.rajaongkir.com',
        type: 'starter',
        timeout: 5,
        open_timeout: 5
      }
    end
  end
end
