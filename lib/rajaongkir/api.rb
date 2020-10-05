require 'faraday'
require 'faraday_middleware'
require 'rajaongkir/response'

module Rajaongkir
  class API
    attr_accessor :api_key, :host, :type, :timeout, :open_timeout

    # api_key = API Key from RajaOngkir
    # opts[:host] = Host of RajaOngkir
    # opts[:type] = Account Type (starter/basic/pro)
    # opts[:timeout] = Timeout, default 5s
    # opts[:open_timeout] = Open Timeout, default 5s
    def initialize(api_key, opts)
      @api_key = api_key
      @host = opts[:host]
      @type = opts[:type]
      @timeout = opts[:timeout]
      @open_timeout = opts[:open_timeout]
    end

    # Retrieve provinces list from RajaOngkir
    #
    # Example:
    # >> provinces = rajaongkir.province
    # => <Rajaongkir::Response @results=[{"province_id"=>"1", "province"=>"Bali"}, {"province_id"=>"2", "province"=>"Bangka Belitung"}, {"province_id"=>"3", "province"=>"Banten"}]>
    def province(opts = {})
      payload = {
        id: opts[:province_id]
      }.compact

      call(:get, 'province', payload)
    end


    # Retrieve cities list from RajaOngkir
    #
    # Example:
    # >> cities = rajaongkir.city
    # => #<Rajaongkir::Response @results=[{"city_id"=>"1", "province_id"=>"21", "province"=>"Nanggroe Aceh Darussalam (NAD)", "type"=>"Kabupaten", "city_name"=>"Aceh Barat", "postal_code"=>"23681"}, {"city_id"=>"2", "province_id"=>"21", "province"=>"Nanggroe Aceh Darussalam (NAD)", "type"=>"Kabupaten", "city_name"=>"Aceh Barat Daya", "postal_code"=>"23764"}]>
    def city(opts = {})
      payload = {
        id: opts[:city_id],
        province_id: opts[:province_id]
      }.compact

      call(:get, 'city', payload)
    end


    # Retrieve cost from source city to destination city given weight and courier
    #
    # Example:
    # >> cost = rajaongkir.cost(origin: 1, destination: 2, weight: 1, courier: 'jne')
    # => #<Rajaongkir::Response @results=[{"code"=>"jne", "name"=>"Jalur Nugraha Ekakurir (JNE)", "costs"=>[{"service"=>"OKE", "description"=>"Ongkos Kirim Ekonomis", "cost"=>[{"value"=>18000, "etd"=>"4-6", "note"=>""}]}, {"service"=>"REG", "description"=>"Layanan Reguler", "cost"=>[{"value"=>20000, "etd"=>"2-3", "note"=>""}]}]}]>
    def cost(opts = {})
      payload = {
        origin: opts[:origin].to_s,
        destination: opts[:destination].to_s,
        weight: opts[:weight].to_i,
        courier: opts[:courier].to_s
      }.compact

      call(:post, 'cost', payload)
    end

    private

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
