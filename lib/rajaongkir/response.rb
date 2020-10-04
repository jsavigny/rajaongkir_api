module Rajaongkir
  class Response
    attr_accessor :results

    def initialize(data)
      @results = data.dig('results')
    end
  end
end
