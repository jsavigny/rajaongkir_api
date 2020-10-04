require 'faraday'
require 'faraday_middleware'
require 'rajaongkir/response'

module Rajaongkir
  class API
    attr_accessor :api_key, :host, :type, :timeout, :open_timeout

    def initialize(api_key, opts)
      @api_key = api_key
      @host = opts[:host]
      @type = opts[:type]
      @timeout = opts[:timeout]
      @open_timeout = opts[:open_timeout]
    end

    def province(opts = {})
      payload = {
        id: opts[:province_id]
      }.compact

      call(:get, 'province', payload)
    end

    def city(opts = {})
      payload = {
        id: opts[:city_id],
        province_id: opts[:province_id]
      }.compact

      call(:get, 'city', payload)
    end

    def cost(opts = {})
      payload = {
        origin: opts[:origin].to_s,
        destination: opts[:destination].to_s,
        weight: opts[:weight].to_i,
        courier: opts[:courier].to_s
      }.compact

      call(:post, 'cost', payload)
    end

    def call(method, path, payload)
      start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

      response = connection.send(method, path, payload)

      duration = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time

      rajaongkir_response = verify(response)
      Rajaongkir::Response.new(rajaongkir_response)
    rescue Faraday::ConnectionFailed => e
      raise Rajaongkir::OpenTimeoutError.new(e.message)
    rescue Faraday::TimeoutError => e
      raise Rajaongkir::ReadTimeoutError.new(e.message)
    rescue Faraday::Error => e
      raise Rajaongkir::ConnectionError.new(e.message)
    rescue => e
      raise e
    end

    def verify(response)
      raise Rajaongkir::SystemError.new('Connection Error') unless response.body

      body = response.body
      status = body.dig('rajaongkir', 'status')

      raise Rajaongkir::Error.new("Error: #{status.dig('description')}") if status.dig('code') >= 400

      body.dig('rajaongkir')
    end


    private

    def url
      case @type
      when 'pro'
        'https://pro.rajaongkir.com/api'
      else
        "#{@host}/#{@type}"
      end
    end

    def connection
      @_connection ||= Faraday.new(url: url) do |c|
        c.request :json
        c.response :json
        c.headers['Content-Type'] = 'application/json'
        c.headers['key'] = @api_key

        c.options.timeout      = @timeout
        c.options.open_timeout = @open_timeout

        c.adapter Faraday.default_adapter
      end
    end
  end
end
