# frozen_string_literal: true

module MetricaApi
  # Yandex Metrica request module
  module Request

    module_function

    def make_request(options, params = {})

      params[:oauth_token] = options.fetch(:oauth_token)
      response = RestClient::Request.execute(build(options, params))
      MetricaApi.logger << response if MetricaApi.logger
      response
    rescue RestClient::Unauthorized,
           RestClient::Forbidden,
           RestClient::BadRequest,
           RestClient::ResourceNotFound => e
      raise MetricaApi::RequestError,
            "url: #{build_url(options)}?#{params.to_query}, original: #{e.message}"
    rescue SocketError => e
      raise MetricaApi::ConnectionError, e.message

    end

    def build(options, params)
      params[:oauth_token] = options.fetch(:oauth_token)
      {
        method: :get,
        url: build_url(options),
        headers: { params: params },
        log: MetricaApi.logger
      }.compact
    end

    def build_url(options)
      api_section = options[:api_section]
      version = options[:v] || DEFAULT_VERSION
      method = options[:method]
      format = options[:format] || DEFAULT_FORMAT
      "#{API_HOST}/#{api_section}/#{version}/#{method}.#{format}"
    end

  end
end
