module Rajaongkir
  class Error < StandardError; end
  class ConnectionError < Error; end
  class OpenTimeoutError < ConnectionError; end
  class ReadTimeoutError < ConnectionError; end
  class SystemError < ConnectionError; end
end
