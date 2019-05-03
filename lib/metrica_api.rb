# frozen_string_literal: true

require 'restclient'
require 'json'
require 'metrica_api/sections/reporting'
require 'metrica_api/sections/counters'

# Yandex Metrica API module
class MetricaApi

  API_HOST = 'https://api-metrika.yandex.net'
  DEFAULT_VERSION = 'v1'
  DEFAULT_FORMAT = 'json'

  autoload :Response, 'metrica_api/response'
  autoload :Request,  'metrica_api/request'
  autoload :Session,  'metrica_api/session'

  autoload :ConnectionError, 'metrica_api/errors/connection_error'
  autoload :RequestError,    'metrica_api/errors/request_error'

  autoload :Counters,  'metrica_api/sections/counters'
  autoload :Reporting, 'metrica_api/sections/reporting'

  class << self

    attr_accessor :logger

    # @param options [Hash<:api_section, :method, :oauth_token[, :v[, :format]]>] path to method
    # @param params [Hash] params for method
    # @result [Hash] response as ruby plain object
    def call(options, params)
      response_parser.parse(request.call(options, params).to_s)
    end

    def counters(token)
      Sections::Counters.new(token)
    end

    def reporting(token)
      Sections::Reporting.new(token)
    end

    def response_parser
      Response
    end

    def request
      Request
    end

  end

end
