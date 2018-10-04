# frozen_string_literal: true

class MetricaApi
  # Metrica Api session object
  class Session

    def initialize(token)
      @token = token
    end

    def call(options, params)
      MetricaApi.call(options.merge(oauth_token: token), params)
    end

    private

    attr_reader :token

  end
end
