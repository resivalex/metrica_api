# frozen_string_literal: true

class MetricaApi
  # Yandex Metrica request
  class Request

    def self.call(options, params = {})
      Request.new(options, params).call
    end

    def initialize(options, params = {})
      @options = options
      @params = params
    end

    def call
      execute!.tap do |response|
        if logger
          logger << full_url
          logger << response
        end
      end
    rescue RestClient::Unauthorized,
      RestClient::Forbidden,
      RestClient::BadRequest,
      RestClient::ResourceNotFound => e
      raise MetricaApi::RequestError,
            "url: #{full_url}, original: #{e.message}"
    rescue SocketError => e
      raise MetricaApi::ConnectionError, e.message
    end

    private

    attr_reader :options, :params

    def execute!
      RestClient::Request.execute(rest_client_options)
    end

    def rest_client_options
      {
        method: :get,
        url: base_url,
        headers: { params: params_with_token },
        log: MetricaApi.logger
      }.compact
    end

    def logger
      MetricaApi.logger
    end

    def full_url
      "#{base_url}?#{query}"
    end

    def query
      params_with_token.map do |key, value|
        [CGI.escape(key.to_s), '=', CGI.escape(value.to_s)]
      end.map(&:join).join('&')
    end

    def params_with_token
      @_params_with_token ||= params.merge(oauth_token: options.fetch(:oauth_token))
    end

    def base_url
      @_base_url ||= begin
        api_section = options[:api_section]
        version = options[:v] || DEFAULT_VERSION
        method = options[:method]
        format = options[:format] || DEFAULT_FORMAT
        "#{API_HOST}/#{api_section}/#{version}/#{method}.#{format}"
      end
    end

  end
end
